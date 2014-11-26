set_halcyon_vars () {
	# NOTE: Recursive vars are set once and inherited.

	if ! (( ${HALCYON_INTERNAL_RECURSIVE_VARS:-0} )); then
		export HALCYON_INTERNAL_RECURSIVE_VARS=1

		# NOTE: HALCYON_BASE is set in paths.sh.

		export HALCYON_PREFIX="${HALCYON_PREFIX:-${HALCYON_BASE}}"
		export HALCYON_ROOT="${HALCYON_ROOT:-/}"
		export HALCYON_NO_APP="${HALCYON_NO_APP:-0}"
		export HALCYON_NO_BUILD="${HALCYON_NO_BUILD:-0}"
		export HALCYON_NO_BUILD_DEPENDENCIES="${HALCYON_NO_BUILD_DEPENDENCIES:-0}"

		export HALCYON_CACHE="${HALCYON_CACHE:-/var/tmp/halcyon-cache}"
		export HALCYON_PURGE_CACHE="${HALCYON_PURGE_CACHE:-0}"
		export HALCYON_NO_ARCHIVE="${HALCYON_NO_ARCHIVE:-0}"
		export HALCYON_NO_CLEAN_CACHE="${HALCYON_NO_CLEAN_CACHE:-0}"

		export HALCYON_PUBLIC_STORAGE="${HALCYON_PUBLIC_STORAGE:-https://s3.halcyon.sh}"
		export HALCYON_NO_PUBLIC_STORAGE="${HALCYON_NO_PUBLIC_STORAGE:-0}"

		export HALCYON_AWS_ACCESS_KEY_ID="${HALCYON_AWS_ACCESS_KEY_ID:-}"
		export HALCYON_AWS_SECRET_ACCESS_KEY="${HALCYON_AWS_SECRET_ACCESS_KEY:-}"
		export HALCYON_S3_BUCKET="${HALCYON_S3_BUCKET:-}"
		export HALCYON_S3_ENDPOINT="${HALCYON_S3_ENDPOINT:-s3.amazonaws.com}"
		export HALCYON_S3_ACL="${HALCYON_S3_ACL:-private}"
		export HALCYON_NO_PRIVATE_STORAGE="${HALCYON_NO_PRIVATE_STORAGE:-0}"
		export HALCYON_NO_UPLOAD="${HALCYON_NO_UPLOAD:-0}"
		export HALCYON_NO_CLEAN_PRIVATE_STORAGE="${HALCYON_NO_CLEAN_PRIVATE_STORAGE:-0}"

		export HALCYON_GHC_VERSION="${HALCYON_GHC_VERSION:-7.8.3}"
		export HALCYON_GHC_PRE_BUILD_HOOK="${HALCYON_GHC_PRE_BUILD_HOOK:-}"
		export HALCYON_GHC_POST_BUILD_HOOK="${HALCYON_GHC_POST_BUILD_HOOK:-}"

		# NOTE: Cabal does not support HTTPS repository URLs.
		# https://github.com/haskell/cabal/issues/936

		export HALCYON_CABAL_VERSION="${HALCYON_CABAL_VERSION:-1.20.0.3}"
		export HALCYON_CABAL_REPO="${HALCYON_CABAL_REPO:-Hackage:http://hackage.haskell.org/packages/archive}"
		export HALCYON_CABAL_PRE_BUILD_HOOK="${HALCYON_CABAL_PRE_BUILD_HOOK:-}"
		export HALCYON_CABAL_POST_BUILD_HOOK="${HALCYON_CABAL_POST_BUILD_HOOK:-}"
		export HALCYON_CABAL_PRE_UPDATE_HOOK="${HALCYON_CABAL_PRE_UPDATE_HOOK:-}"
		export HALCYON_CABAL_POST_UPDATE_HOOK="${HALCYON_CABAL_POST_UPDATE_HOOK:-}"

		export HALCYON_INTERNAL_RECURSIVE="${HALCYON_INTERNAL_RECURSIVE:-0}"
		export HALCYON_INTERNAL_NONLOCAL_SOURCE="${HALCYON_INTERNAL_NONLOCAL_SOURCE:-0}"
		export HALCYON_INTERNAL_ONLY="${HALCYON_INTERNAL_ONLY:-}"
		export HALCYON_INTERNAL_NO_COPY_LOCAL_SOURCE="${HALCYON_INTERNAL_NO_COPY_LOCAL_SOURCE:-0}"
		export HALCYON_INTERNAL_GHC_MAGIC_HASH="${HALCYON_INTERNAL_GHC_MAGIC_HASH:-}"
		export HALCYON_INTERNAL_CABAL_MAGIC_HASH="${HALCYON_INTERNAL_CABAL_MAGIC_HASH:-}"
	fi

	# NOTE: Non-recursive vars are inherited once, then reset to default.

	if ! (( ${HALCYON_INTERNAL_NONRECURSIVE_VARS:-0} )); then
		export HALCYON_INTERNAL_NONRECURSIVE_VARS=1

		export HALCYON_CONSTRAINTS="${HALCYON_CONSTRAINTS:-}"
		export HALCYON_EXTRA_APPS="${HALCYON_EXTRA_APPS:-}"
		export HALCYON_EXTRA_APPS_CONSTRAINTS="${HALCYON_EXTRA_APPS_CONSTRAINTS:-}"
		export HALCYON_PRE_INSTALL_HOOK="${HALCYON_PRE_INSTALL_HOOK:-}"
		export HALCYON_POST_INSTALL_HOOK="${HALCYON_POST_INSTALL_HOOK:-}"
		export HALCYON_RESTORE_DEPENDENCIES="${HALCYON_RESTORE_DEPENDENCIES:-0}"
		export HALCYON_KEEP_DEPENDENCIES="${HALCYON_KEEP_DEPENDENCIES:-0}"

		export HALCYON_GHC_REBUILD="${HALCYON_GHC_REBUILD:-0}"

		export HALCYON_CABAL_REBUILD="${HALCYON_CABAL_REBUILD:-0}"
		export HALCYON_CABAL_UPDATE="${HALCYON_CABAL_UPDATE:-0}"

		export HALCYON_SANDBOX_SOURCES="${HALCYON_SANDBOX_SOURCES:-}"
		export HALCYON_SANDBOX_EXTRA_APPS="${HALCYON_SANDBOX_EXTRA_APPS:-}"
		export HALCYON_SANDBOX_EXTRA_APPS_CONSTRAINTS="${HALCYON_SANDBOX_EXTRA_APPS_CONSTRAINTS:-}"
		export HALCYON_SANDBOX_EXTRA_LIBS="${HALCYON_SANDBOX_EXTRA_LIBS:-}"
		export HALCYON_SANDBOX_PRE_BUILD_HOOK="${HALCYON_SANDBOX_PRE_BUILD_HOOK:-}"
		export HALCYON_SANDBOX_POST_BUILD_HOOK="${HALCYON_SANDBOX_POST_BUILD_HOOK:-}"
		export HALCYON_SANDBOX_REBUILD="${HALCYON_SANDBOX_REBUILD:-0}"

		export HALCYON_APP_EXTRA_CONFIGURE_FLAGS="${HALCYON_APP_EXTRA_CONFIGURE_FLAGS:-}"
		export HALCYON_APP_EXTRA_COPY="${HALCYON_APP_EXTRA_COPY:-}"
		export HALCYON_APP_PRE_BUILD_HOOK="${HALCYON_APP_PRE_BUILD_HOOK:-}"
		export HALCYON_APP_POST_BUILD_HOOK="${HALCYON_APP_POST_BUILD_HOOK:-}"
		export HALCYON_APP_REBUILD="${HALCYON_APP_REBUILD:-0}"
		export HALCYON_APP_RECONFIGURE="${HALCYON_APP_RECONFIGURE:-0}"

		export HALCYON_INTERNAL_NO_ANNOUNCE_DEPLOY="${HALCYON_INTERNAL_NO_ANNOUNCE_DEPLOY:-0}"
	else
		export HALCYON_CONSTRAINTS=''
		export HALCYON_EXTRA_APPS=''
		export HALCYON_EXTRA_APPS_CONSTRAINTS=''
		export HALCYON_PRE_INSTALL_HOOK=''
		export HALCYON_POST_INSTALL_HOOK=''
		export HALCYON_RESTORE_DEPENDENCIES=0
		export HALCYON_KEEP_DEPENDENCIES=0

		export HALCYON_GHC_REBUILD=0

		export HALCYON_CABAL_REBUILD=0
		export HALCYON_CABAL_UPDATE=0

		export HALCYON_SANDBOX_SOURCES=''
		export HALCYON_SANDBOX_EXTRA_APPS=''
		export HALCYON_SANDBOX_EXTRA_APPS_CONSTRAINTS=''
		export HALCYON_SANDBOX_EXTRA_LIBS=''
		export HALCYON_SANDBOX_PRE_BUILD_HOOK=''
		export HALCYON_SANDBOX_POST_BUILD_HOOK=''
		export HALCYON_SANDBOX_REBUILD=0

		export HALCYON_APP_EXTRA_CONFIGURE_FLAGS=''
		export HALCYON_APP_EXTRA_COPY=''
		export HALCYON_APP_PRE_BUILD_HOOK=''
		export HALCYON_APP_POST_BUILD_HOOK=''
		export HALCYON_APP_REBUILD=0
		export HALCYON_APP_RECONFIGURE=0

		export HALCYON_INTERNAL_NO_ANNOUNCE_DEPLOY=0
	fi
}


halcyon_main () {
	local cmd
	local -a args
	cmd=''

	while (( $# )); do
		case "$1" in

	# General options
		'--base')
			shift
			expect_args base_dir -- "$@"
			export HALCYON_BASE="${base_dir}";;
		'--base='*)
			export HALCYON_BASE="${1#*=}";;
		'--prefix')
			shift
			expect_args prefix -- "$@"
			export HALCYON_PREFIX="${prefix}";;
		'--prefix='*)
			export HALCYON_PREFIX="${1#*=}";;
		'--root')
			shift
			expect_args root -- "$@"
			export HALCYON_ROOT="${root}";;
		'--root='*)
			export HALCYON_ROOT="${1#*=}";;
		'--constraints')
			shift
			expect_args constraints -- "$@"
			export HALCYON_CONSTRAINTS="${constraints}";;
		'--constraints='*)
			export HALCYON_CONSTRAINTS="${1#*=}";;
		'--extra-apps')
			shift
			expect_args extra_apps -- "$@"
			export HALCYON_EXTRA_APPS="${extra_apps}";;
		'--extra-apps='*)
			export HALCYON_EXTRA_APPS="${1#*=}";;
		'--extra-apps-constraints')
			shift
			expect_args extra_apps_constraints -- "$@"
			export HALCYON_EXTRA_APPS_CONSTRAINTS="${extra_apps_constraints}";;
		'--extra-apps-constraints='*)
			export HALCYON_EXTRA_APPS_CONSTRAINTS="${1#*=}";;
		'--pre-install-hook')
			shift
			expect_args pre_install_hook -- "$@"
			export HALCYON_PRE_INSTALL_HOOK="${pre_install_hook}";;
		'--pre-install-hook='*)
			export HALCYON_PRE_INSTALL_HOOK="${1#*=}";;
		'--post-install-hook')
			shift
			expect_args post_install_hook -- "$@"
			export HALCYON_POST_INSTALL_HOOK="${post_install_hook}";;
		'--post-install-hook='*)
			export HALCYON_POST_INSTALL_HOOK="${1#*=}";;
		'--restore-dependencies')
			export HALCYON_RESTORE_DEPENDENCIES=1;;
		'--keep-dependencies')
			export HALCYON_KEEP_DEPENDENCIES=1;;
		'--no-app')
			export HALCYON_NO_APP=1;;
		'--no-build')
			export HALCYON_NO_BUILD=1;;
		'--no-build-dependencies')
			export HALCYON_NO_BUILD_DEPENDENCIES=1;;

	# Cache options
		'--cache')
			shift
			expect_args cache_dir -- "$@"
			export HALCYON_CACHE="${cache_dir}";;
		'--cache='*)
			export HALCYON_CACHE="${1#*=}";;
		'--purge-cache')
			export HALCYON_PURGE_CACHE=1;;
		'--no-archive')
			export HALCYON_NO_ARCHIVE=1;;
		'--no-clean-cache')
			export HALCYON_NO_CLEAN_CACHE=1;;

	# Public storage options
		'--public-storage')
			shift
			expect_args public_storage -- "$@"
			export HALCYON_PUBLIC_STORAGE="${public_storage}";;
		'--public-storage='*)
			export HALCYON_PUBLIC_STORAGE="${1#*=}";;
		'--no-public-storage')
			export HALCYON_NO_PUBLIC_STORAGE=1;;

	# Private storage options
		'--aws-access-key-id')
			shift
			expect_args aws_access_key_id -- "$@"
			export HALCYON_AWS_ACCESS_KEY_ID="${aws_access_key_id}";;
		'--aws-access-key-id='*)
			export HALCYON_AWS_ACCESS_KEY_ID="${1#*=}";;
		'--aws-secret-access-key')
			shift
			expect_args aws_secret_access_key -- "$@"
			export HALCYON_AWS_SECRET_ACCESS_KEY="${aws_secret_access_key}";;
		'--aws-secret-access-key='*)
			export HALCYON_AWS_SECRET_ACCESS_KEY="${1#*=}";;
		'--s3-bucket')
			shift
			expect_args s3_bucket -- "$@"
			export HALCYON_S3_BUCKET="${s3_bucket}";;
		'--s3-bucket='*)
			export HALCYON_S3_BUCKET="${1#*=}";;
		'--s3-endpoint')
			shift
			expect_args s3_endpoint -- "$@"
			export HALCYON_S3_ENDPOINT="${s3_endpoint}";;
		'--s3-endpoint='*)
			export HALCYON_S3_ENDPOINT="${1#*=}";;
		'--s3-acl')
			shift
			expect_args s3_acl -- "$@"
			export HALCYON_S3_ACL="${s3_acl}";;
		'--s3-acl='*)
			export HALCYON_S3_ACL="${1#*=}";;
		'--no-private-storage')
			export HALCYON_NO_PRIVATE_STORAGE=1;;
		'--no-upload')
			export HALCYON_NO_UPLOAD=1;;
		'--no-clean-private-storage')
			export HALCYON_NO_CLEAN_PRIVATE_STORAGE=1;;

	# GHC layer options
		'--ghc-version')
			shift
			expect_args ghc_version -- "$@"
			export HALCYON_GHC_VERSION="${ghc_version}";;
		'--ghc-version='*)
			export HALCYON_GHC_VERSION="${1#*=}";;
		'--ghc-pre-build-hook')
			shift
			expect_args ghc_pre_build_hook -- "$@"
			export HALCYON_GHC_PRE_BUILD_HOOK="${ghc_pre_build_hook}";;
		'--ghc-pre-build-hook='*)
			export HALCYON_GHC_PRE_BUILD_HOOK="${1#*=}";;
		'--ghc-post-build-hook')
			shift
			expect_args ghc_post_build_hook -- "$@"
			export HALCYON_GHC_POST_BUILD_HOOK="${ghc_post_build_hook}";;
		'--ghc-post-build-hook='*)
			export HALCYON_GHC_POST_BUILD_HOOK="${1#*=}";;
		'--ghc-rebuild')
			export HALCYON_GHC_REBUILD=1;;

	# Cabal layer options
		'--cabal-version')
			shift
			expect_args cabal_version -- "$@"
			export HALCYON_CABAL_VERSION="${cabal_version}";;
		'--cabal-version='*)
			export HALCYON_CABAL_VERSION="${1#*=}";;
		'--cabal-repo')
			shift
			expect_args cabal_repo -- "$@"
			export HALCYON_CABAL_REPO="${cabal_repo}";;
		'--cabal-repo='*)
			export HALCYON_CABAL_REPO="${1#*=}";;
		'--cabal-pre-build-hook')
			shift
			expect_args cabal_pre_build_hook -- "$@"
			export HALCYON_CABAL_PRE_BUILD_HOOK="${cabal_pre_build_hook}";;
		'--cabal-pre-build-hook='*)
			export HALCYON_CABAL_PRE_BUILD_HOOK="${1#*=}";;
		'--cabal-post-build-hook')
			shift
			expect_args cabal_post_build_hook -- "$@"
			export HALCYON_CABAL_POST_BUILD_HOOK="${cabal_post_build_hook}";;
		'--cabal-post-build-hook='*)
			export HALCYON_CABAL_POST_BUILD_HOOK="${1#*=}";;
		'--cabal-pre-update-hook')
			shift
			expect_args cabal_pre_update_hook -- "$@"
			export HALCYON_CABAL_PRE_UPDATE_HOOK="${cabal_pre_update_hook}";;
		'--cabal-pre-update-hook='*)
			export HALCYON_CABAL_PRE_UPDATE_HOOK="${1#*=}";;
		'--cabal-post-update-hook')
			shift
			expect_args cabal_post_update_hook -- "$@"
			export HALCYON_CABAL_POST_UPDATE_HOOK="${cabal_post_update_hook}";;
		'--cabal-post-update-hook='*)
			export HALCYON_CABAL_POST_UPDATE_HOOK="${1#*=}";;
		'--cabal-rebuild')
			export HALCYON_CABAL_REBUILD=1;;
		'--cabal-update')
			export HALCYON_CABAL_UPDATE=1;;

	# Sandbox layer options
		'--sandbox-sources')
			shift
			expect_args sandbox_sources -- "$@"
			export HALCYON_SANDBOX_SOURCES="${sandbox_sources}";;
		'--sandbox-sources='*)
			export HALCYON_SANDBOX_SOURCES="${1#*=}";;
		'--sandbox-extra-apps')
			shift
			expect_args sandbox_extra_apps -- "$@"
			export HALCYON_SANDBOX_EXTRA_APPS="${sandbox_extra_apps}";;
		'--sandbox-extra-apps='*)
			export HALCYON_SANDBOX_EXTRA_APPS="${1#*=}";;
		'--sandbox-extra-apps-constraints')
			shift
			expect_args sandbox_extra_apps_constraints -- "$@"
			export HALCYON_SANDBOX_EXTRA_APPS_CONSTRAINTS="${sandbox_extra_apps_constraints}";;
		'--sandbox-extra-apps-constraints='*)
			export HALCYON_SANDBOX_EXTRA_APPS_CONSTRAINTS="${1#*=}";;
		'--sandbox-extra-libs')
			shift
			expect_args sandbox_extra_libs -- "$@"
			export HALCYON_SANDBOX_EXTRA_LIBS="${sandbox_extra_libs}";;
		'--sandbox-extra-libs='*)
			export HALCYON_SANDBOX_EXTRA_LIBS="${1#*=}";;
		'--sandbox-pre-build-hook')
			shift
			expect_args sandbox_pre_build_hook -- "$@"
			export HALCYON_SANDBOX_PRE_BUILD_HOOK="${sandbox_pre_build_hook}";;
		'--sandbox-pre-build-hook='*)
			export HALCYON_SANDBOX_PRE_BUILD_HOOK="${1#*=}";;
		'--sandbox-post-build-hook')
			shift
			expect_args sandbox_post_build_hook -- "$@"
			export HALCYON_SANDBOX_POST_BUILD_HOOK="${sandbox_post_build_hook}";;
		'--sandbox-post-build-hook='*)
			export HALCYON_SANDBOX_POST_BUILD_HOOK="${1#*=}";;
		'--sandbox-rebuild')
			export HALCYON_SANDBOX_REBUILD=1;;

	# App options
		'--app-extra-configure-flags')
			shift
			expect_args app_extra_configure_flags -- "$@"
			export HALCYON_APP_EXTRA_CONFIGURE_FLAGS="${app_extra_configure_flags}";;
		'--app-extra-configure-flags='*)
			export HALCYON_APP_EXTRA_CONFIGURE_FLAGS="${1#*=}";;
		'--app-extra-copy')
			shift
			expect_args app_extra_copy -- "$@"
			export HALCYON_APP_EXTRA_COPY="${app_extra_copy}";;
		'--app-extra-copy='*)
			export HALCYON_APP_EXTRA_COPY="${1#*=}";;
		'--app-pre-build-hook')
			shift
			expect_args app_pre_build_hook -- "$@"
			export HALCYON_APP_PRE_BUILD_HOOK="${app_pre_build_hook}";;
		'--app-pre-build-hook='*)
			export HALCYON_APP_PRE_BUILD_HOOK="${1#*=}";;
		'--app-post-build-hook')
			shift
			expect_args app_post_build_hook -- "$@"
			export HALCYON_APP_POST_BUILD_HOOK="${app_post_build_hook}";;
		'--app-post-build-hook='*)
			export HALCYON_APP_POST_BUILD_HOOK="${1#*=}";;
		'--app-rebuild')
			export HALCYON_APP_REBUILD=1;;
		'--app-reconfigure')
			export HALCYON_APP_RECONFIGURE=1;;

		'--')
			shift
			while (( $# )); do
				if [[ -z "${cmd}" ]]; then
					cmd="$1"
				else
					args+=( "$1" )
				fi
				shift
			done
			;;
		'-'*)
			log_error "Unexpected option: $1"
			help_usage
			die
			;;
		*)
			if [[ -z "${cmd}" ]]; then
				cmd="$1"
			else
				args+=( "$1" )
			fi
		esac
		shift
	done

	# NOTE: HALCYON_CACHE must not be /tmp, as the cache cleaning
	# functionality will get confused.

	if [[ "${HALCYON_CACHE}" == '/tmp' ]]; then
		export HALCYON_CACHE='/tmp/halcyon-cache'
	fi

	if [[ -n "${HALCYON_CABAL_REPO}" ]]; then
		local repo_name
		repo_name="${HALCYON_CABAL_REPO%%:*}"
		if [[ -z "${repo_name}" ]]; then
			log_error "Unexpected Cabal repo: ${HALCYON_CABAL_REPO}"
			die "Expected Cabal repo: RepoName:${HALCYON_CABAL_REPO}"
		fi
	fi

	case "${HALCYON_APP_EXTRA_COPY}" in
	'source');&
	'build');&
	'all');&
	'')
		true;;
	*)
		log_error "Unexpected app extra copy: ${HALCYON_APP_EXTRA_COPY}"
		die "Expected app extra copy: source or build or all"
	esac

	if [[ -z "${cmd}" ]]; then
		log_error 'Expected command'
		help_usage
		die
	fi

	case "${cmd}" in
	'deploy')
		halcyon_deploy "${args[@]:-}" || return 1
		;;
	'label')
		HALCYON_INTERNAL_ONLY='label' \
			halcyon_deploy "${args[@]:-}" || return 1
		;;
	'constraints')
		HALCYON_INTERNAL_ONLY='constraints' \
			halcyon_deploy "${args[@]:-}" || return 1
		;;
	'tag')
		HALCYON_INTERNAL_ONLY='tag' \
			halcyon_deploy "${args[@]:-}" || return 1
		;;
	'paths')
		echo -e "export HALCYON_INSTALL='${HALCYON_INSTALL}'\n"

		cat "${HALCYON_INSTALL}/src/paths.sh" || die
		;;
	*)
		log_error "Unexpected command: ${cmd} ${args[*]:-}"
		help_usage
		die
	esac
}
