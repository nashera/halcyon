function prepare_cache () {
	expect_vars HALCYON_CACHE_DIR HALCYON_TMP_CACHE_DIR HALCYON_PURGE_CACHE

	if (( HALCYON_PURGE_CACHE )); then
		log 'Purging cache'

		rm -rf "${HALCYON_CACHE_DIR}"
	fi

	log 'Preparing cache'

	mkdir -p "${HALCYON_CACHE_DIR}" || die
	rm -f "${HALCYON_CACHE_DIR}/.halcyon-mark" || die

	log 'Examining cache contents'

	local files
	if files=$(
		find "${HALCYON_CACHE_DIR}" -type f 2>'/dev/null' |
		sed "s:^${HALCYON_CACHE_DIR}/::" |
		sort_naturally |
		match_at_least_one
	); then
		tar_copy "${HALCYON_CACHE_DIR}" "${HALCYON_TMP_CACHE_DIR}" || die

		quote <<<"${files}"
	else
		log_indent '(none)'
	fi

	touch "${HALCYON_CACHE_DIR}/.halcyon-mark" || die
}


function clean_cache () {
	expect_vars HALCYON_DIR HALCYON_CACHE_DIR HALCYON_TMP_CACHE_DIR
	expect_existing "${HALCYON_CACHE_DIR}/.halcyon-mark"

	log 'Cleaning cache'

	local mark_time
	mark_time=$( get_file_modification_time "${HALCYON_CACHE_DIR}/.halcyon-mark" ) || die

	rm -f "${HALCYON_CACHE_DIR}/.halcyon-mark" "${HALCYON_CACHE_DIR}/"*".cabal.config" || die

	local file
	find "${HALCYON_CACHE_DIR}" -type f 2>'/dev/null' |
		while read -r file; do
			local file_time
			file_time=$( get_file_modification_time "${file}" ) || die
			if (( file_time < mark_time )); then
				rm -f "${file}" || die
			fi
		done

	log 'Examining cache changes'

	local changed_files
	if changed_files=$(
		compare_tree "${HALCYON_TMP_CACHE_DIR}" "${HALCYON_CACHE_DIR}" |
		filter_not_matching '^= ' |
		match_at_least_one
	); then
		quote <<<"${changed_files}"
	else
		log_indent '(none)'
	fi

	rm -rf "${HALCYON_TMP_CACHE_DIR}" || die
}
