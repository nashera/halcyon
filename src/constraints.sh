#!/usr/bin/env bash


function echo_tmp_constraints_config () {
	mktemp -u '/tmp/halcyon-constraints.cabal.config.XXXXXXXXXX'
}




function echo_constraints_digest () {
	openssl sha1 | sed 's/^.* //'
}


function echo_customize_sandbox_script_digest () {
	openssl sha1 | sed 's/^.* //'
}




function echo_constraints () {
	awk 'BEGIN { printf "constraints:"; separator = " " }
		/^--customize-sandbox-script-digest: / { script_digest = $2 }
		!/^--/ && !/^$/ { printf "%s%s ==%s", separator, $1, $2; separator = ",\n             " }
		END { printf "\n"; if (script_digest != "") printf "--customize-sandbox-script-digest: %s\n", script_digest }'
}


function echo_constraints_difference () {
	expect_args old_constraints new_constraints -- "$@"

	local old_digest new_digest
	old_digest=$( echo_constraints_digest <<<"${old_constraints}" ) || die
	new_digest=$( echo_constraints_digest <<<"${new_constraints}" ) || die

	local tmp_old_config tmp_new_config
	tmp_old_config=$( echo_tmp_constraints_config ) || die
	tmp_new_config=$( echo_tmp_constraints_config ) || die

	echo_constraints <<<"${old_constraints}" >"${tmp_old_config}" || die
	echo_constraints <<<"${new_constraints}" >"${tmp_new_config}" || die

	echo "--- ${old_digest:0:7}/cabal.config"
	echo "+++ ${new_digest:0:7}/cabal.config"
	diff -u "${tmp_old_config}" "${tmp_new_config}" | tail -n +3 || true

	rm -f "${tmp_old_config}" "${tmp_new_config}" || die
}




function read_constraints () {
	awk '/^ *[Cc]onstraints:/, !/[:,]/ { print }' |
		sed 's/[Cc]onstraints://;s/[, ]//g;s/==/ /;/^$/d'
}


function read_constraints_dry_run () {
	tail -n +3 |
		sed 's/ == / /'
}




function filter_valid_constraints () {
	local -A constraints_A

	local candidate_package candidate_version
	while read -r candidate_package candidate_version; do
		if [ -n "${constraints_A[${candidate_package}]:+_}" ]; then
			die "Expected at most one ${candidate_package} constraint"
		fi
		constraints_A["${candidate_package}"]="${candidate_version}"

		echo "${candidate_package} ${candidate_version}"
	done

	if [ -z "${constraints_A[base]:+_}" ]; then
		die 'Expected base constraint'
	fi
}


function score_constraints () {
	local constraints sandbox_tag
	expect_args constraints sandbox_tag -- "$@"

	local sandbox_description
	sandbox_description=$( echo_sandbox_description "${sandbox_tag}" ) || die

	local -A constraints_A

	local package version
	while read -r package version; do
		constraints_A["${package}"]="${version}"
	done <<<"${constraints}"

	local script_digest candidate_digest
	script_digest="${constraints_A[--customize-sandbox-script-digest:]:-}"
	candidate_digest=""

	local score candidate_package candidate_version
	score=0
	while read -r candidate_package candidate_version; do
		if [ "${candidate_package}" = "--customize-sandbox-script-digest:" ]; then
			candidate_digest="${candidate_version}"
			if [ -z "${script_digest}" ]; then
				log_indent "Ignoring ${sandbox_description} as customize sandbox script is not needed"
				echo 0
				return 0
			fi
			if [ "${candidate_digest}" != "${script_digest}" ]; then
				log_indent "Ignoring ${sandbox_description} as customize sandbox script ${script_digest:0:7} is needed and not ${candidate_digest:0:7}"
				echo 0
				return 0
			fi
		else
			local version
			version="${constraints_A[${candidate_package}]:-}"
			if [ -z "${version}" ]; then
				log_indent "Ignoring ${sandbox_description} as ${candidate_package} is not needed"
				echo 0
				return 0
			fi
			if [ "${candidate_version}" != "${version}" ]; then
				log_indent "Ignoring ${sandbox_description} as ${candidate_package}-${version} is needed and not ${candidate_version}"
				echo 0
				return 0
			fi
		fi
		score=$(( ${score} + 1 ))
	done

	if [ -z "${candidate_digest}" ]; then
		log_indent "Ignoring ${sandbox_description} as customize sandbox script ${script_digest:0:7} is needed"
		echo 0
		return 0
	fi

	log_indent "${score}"$'\t'"${sandbox_description}"
	echo "${score}"
}




function detect_app_constraint () {
	local build_dir
	expect_args build_dir -- "$@"

	local app_name app_version
	app_name=$( detect_app_name "${build_dir}" ) || die
	app_version=$( detect_app_version "${build_dir}" ) || die

	echo "${app_name} ${app_version}"
}


function filter_correct_constraints () {
	local build_dir
	expect_args build_dir -- "$@"

	# NOTE: An application should not be its own dependency.
	# https://github.com/haskell/cabal/issues/1908

	local app_constraint
	app_constraint=$( detect_app_constraint "${build_dir}" ) || die

	filter_valid_constraints |
		filter_not_matching "^${app_constraint}$" |
		sort_naturally
}




function detect_constraints () {
	local build_dir
	expect_args build_dir -- "$@"
	expect_existing "${build_dir}/cabal.config"

	read_constraints <"${build_dir}/cabal.config" |
		filter_correct_constraints "${build_dir}" || die
}




function detect_customize_sandbox_script_constraint () {
	filter_matching "^--customize-sandbox-script-digest: " |
		match_exactly_one
}


function insert_customize_sandbox_script_constraint () {
	local build_dir
	expect_args build_dir -- "$@"

	if has_vars HALCYON_CUSTOMIZE_SANDBOX_SCRIPT; then
		expect_existing "${build_dir}/${HALCYON_CUSTOMIZE_SANDBOX_SCRIPT}"

		local script_digest
		script_digest=$( echo_customize_sandbox_script_digest <"${build_dir}/${HALCYON_CUSTOMIZE_SANDBOX_SCRIPT}" ) || die

		awk 'BEGIN { print "--customize-sandbox-script-digest: '"${script_digest}"'" } { print }'
	else
		awk '{ print }'
	fi
}




function freeze_implicit_constraints () {
	local build_dir
	expect_args build_dir -- "$@"
	expect_existing "${build_dir}"

	cabal_do "${build_dir}" --no-require-sandbox freeze --dry-run |
		read_constraints_dry_run |
		insert_customize_sandbox_script_constraint "${build_dir}" |
		filter_correct_constraints "${build_dir}" || die
}


function freeze_actual_constraints () {
	local sandbox_dir build_dir
	expect_args sandbox_dir build_dir -- "$@"

	sandboxed_cabal_do "${sandbox_dir}" "${build_dir}" freeze --dry-run |
		read_constraints_dry_run |
		insert_customize_sandbox_script_constraint "${build_dir}" |
		filter_correct_constraints "${build_dir}" || die
}
