#!/usr/bin/env bash




##
## # Build Lingmo ISO / Steps
##


##
## ## Main / Init
##

REF_BASE_DIR_PATH="$(cd -- "$(dirname -- "$0")" ; pwd)"
REF_CMD_FILE_NAME="$(basename "$0")"


DEFAULT_IS_DEBUG="false"
IS_DEBUG="${IS_DEBUG:=$DEFAULT_IS_DEBUG}"


##
## ## Main / Util
##

util_error_echo () {
	echo "${@}" 1>&2
}

util_debug_echo () {

	if is_debug; then
		echo "${@}" 1>&2
	fi

}

is_debug () {

	if [[ "${IS_DEBUG}" == "true" ]]; then
		return 0
	fi

	return 1

}

is_not_debug () {

	! is_debug

}


##
## ## Main / Variable
##

main_var_init () {

	##
	## ## Plan / Path
	##

	REF_MAIN_SUBJECT_NAME="lingmo"
	REF_PLAN_DIR_PATH="${REF_BASE_DIR_PATH}"



	REF_PLAN_ASSET_DIR_NAME="asset"
	REF_PLAN_ASSET_DIR_PATH="${REF_PLAN_DIR_PATH}/${REF_PLAN_ASSET_DIR_NAME}"


	REF_PLAN_FACTORY_DIR_NAME="factory"
	REF_PLAN_FACTORY_DIR_PATH="${REF_PLAN_DIR_PATH}/${REF_PLAN_FACTORY_DIR_NAME}"


	REF_PLAN_TMP_DIR_NAME="tmp"
	REF_PLAN_TMP_DIR_PATH="${REF_PLAN_DIR_PATH}/${REF_PLAN_TMP_DIR_NAME}"

	#REF_PLAN_TMP_DIR_PATH="${HOME}/${REF_PLAN_TMP_DIR_NAME}/${REF_MAIN_SUBJECT_NAME}"
	REF_PLAN_TMP_DIR_PATH="/opt/${REF_PLAN_TMP_DIR_NAME}/${REF_MAIN_SUBJECT_NAME}"


	REF_PLAN_WORK_DIR_NAME="work"
	REF_PLAN_WORK_DIR_PATH="${REF_PLAN_TMP_DIR_PATH}/${REF_PLAN_WORK_DIR_NAME}"

	REF_PLAN_OUT_DIR_NAME="out"
	REF_PLAN_OUT_DIR_PATH="${REF_PLAN_TMP_DIR_PATH}/${REF_PLAN_OUT_DIR_NAME}"


	return 0
}

main_var_dump () {

	is_not_debug && return 0


	util_debug_echo
	util_debug_echo "##"
	util_debug_echo "## ## Tips"
	util_debug_echo "##"
	util_debug_echo
	util_debug_echo "> Hide Dump Info"
	util_debug_echo
	util_debug_echo "\$ export IS_DEBUG=false"
	util_debug_echo


	util_debug_echo
	util_debug_echo "##"
	util_debug_echo "## ## Dump / main_var_dump"
	util_debug_echo "##"

	util_debug_echo
	util_debug_echo "REF_BASE_DIR_PATH=${REF_BASE_DIR_PATH}"
	util_debug_echo "REF_CMD_FILE_NAME=${REF_CMD_FILE_NAME}"

	util_debug_echo
	util_debug_echo "DEFAULT_IS_DEBUG=${DEFAULT_IS_DEBUG}"
	util_debug_echo "IS_DEBUG=${IS_DEBUG}"




	util_debug_echo
	util_debug_echo "REF_MAIN_SUBJECT_NAME=${REF_MAIN_SUBJECT_NAME}"
	util_debug_echo "REF_PLAN_DIR_PATH=${REF_PLAN_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_PLAN_ASSET_DIR_NAME=${REF_PLAN_ASSET_DIR_NAME}"
	util_debug_echo "REF_PLAN_ASSET_DIR_PATH=${REF_PLAN_ASSET_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_PLAN_FACTORY_DIR_NAME=${REF_PLAN_FACTORY_DIR_NAME}"
	util_debug_echo "REF_PLAN_FACTORY_DIR_PATH=${REF_PLAN_FACTORY_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_PLAN_TMP_DIR_NAME=${REF_PLAN_TMP_DIR_NAME}"
	util_debug_echo "REF_PLAN_TMP_DIR_PATH=${REF_PLAN_TMP_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_PLAN_WORK_DIR_NAME=${REF_PLAN_WORK_DIR_NAME}"
	util_debug_echo "REF_PLAN_WORK_DIR_PATH=${REF_PLAN_WORK_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_PLAN_OUT_DIR_NAME=${REF_PLAN_OUT_DIR_NAME}"
	util_debug_echo "REF_PLAN_OUT_DIR_PATH=${REF_PLAN_OUT_DIR_PATH}"




	return 0
}

main_var_init

main_var_dump


##
## ## Master / Variable
##

master_var_init () {


	##
	## ## Master / Args
	##

	DEFAULT_BUILD_ARCH="amd64"
	REF_BUILD_ARCH="${REF_BUILD_ARCH:=$DEFAULT_BUILD_ARCH}"
	REF_BUILD_ARCH_OPTION_LIST="amd64 arm64 mips64el loong64 i386"


	##
	## ## Master / Opts
	##

	DEFAULT_MAIN_RUN="steps"
	REF_MAIN_RUN="${REF_MAIN_RUN:=$DEFAULT_MAIN_RUN}"

	DEFAULT_BUILD_LOCALE="en_us"
	REF_BUILD_LOCALE="${REF_BUILD_LOCALE:=$DEFAULT_BUILD_LOCALE}"
	REF_BUILD_LOCALE_OPTION_LIST="en_us zh_tw zh_cn zh_hk ja_jp ko_kr"


	##
	## ## ISO Profile / Path
	##

	REF_ISO_PROFILE_DIR_NAME="iso-profile"
	REF_ISO_PROFILE_DIR_PATH="${REF_PLAN_WORK_DIR_PATH}/${REF_ISO_PROFILE_DIR_NAME}"

	REF_ISO_PROFILE_REPO_GIT_URL="https://github.com/LingmoOS/live-build-config"


	##
	## ## Target OS / Path
	##

	REF_TARGET_OS_ROOT_DIR_NAME="chroot"
	REF_TARGET_OS_ROOT_DIR_PATH="${REF_ISO_PROFILE_DIR_PATH}/${REF_TARGET_OS_ROOT_DIR_NAME}"


	REF_TARGET_OS_ARCHIVE_FILE_NAME="filesystem.squashfs"
	REF_TARGET_OS_ARCHIVE_FILE_PATH="${REF_ISO_PROFILE_DIR_PATH}/${REF_TARGET_OS_ARCHIVE_FILE_NAME}"


	##
	## ## Target OS / debootstrap args
	##

	#DEFAULT_BUILD_ARCH="amd64"
	#REF_BUILD_ARCH="${REF_BUILD_ARCH:=$DEFAULT_BUILD_ARCH}"

	DEFAULT_BUILD_SUITE="bookworm"
	REF_BUILD_SUITE="${REF_BUILD_SUITE:=$DEFAULT_BUILD_SUITE}"

	DEFAULT_PACKAGE_REPO_URL="http://debian-archive.trafficmanager.net/debian"
	REF_PACKAGE_REPO_URL="${REF_PACKAGE_REPO_URL:=$DEFAULT_PACKAGE_REPO_URL}"

	DEFAULT_BUILD_INCLUDE="debian-ports-archive-keyring,debian-archive-keyring,live-task-recommended,live-task-standard,live-config-systemd,live-boot"
	REF_BUILD_INCLUDE="${REF_BUILD_INCLUDE:=$DEFAULT_BUILD_INCLUDE}"


	##
	## ## Overlay / Path
	##

	REF_OVERLAY_DIR_NAME="overlay"
	REF_OVERLAY_DIR_PATH="${REF_PLAN_ASSET_DIR_PATH}/${REF_OVERLAY_DIR_NAME}"

	REF_FACTORY_OVERLAY_DIR_NAME="${REF_OVERLAY_DIR_NAME}"
	REF_FACTORY_OVERLAY_DIR_PATH="${REF_PLAN_FACTORY_DIR_PATH}/${REF_FACTORY_OVERLAY_DIR_NAME}"


	##
	## ## Package List / Path
	##

	REF_PACKAGE_LIST_DIR_NAME="package"
	REF_PACKAGE_LIST_DIR_PATH="${REF_PLAN_ASSET_DIR_PATH}/${REF_PACKAGE_LIST_DIR_NAME}"


	REF_PACKAGE_INSTALL_DIR_NAME="install"
	REF_PACKAGE_INSTALL_DIR_PATH="${REF_PACKAGE_LIST_DIR_PATH}/${REF_PACKAGE_INSTALL_DIR_NAME}"


	REF_PACKAGE_REMOVE_DIR_NAME="remove"
	REF_PACKAGE_REMOVE_DIR_PATH="${REF_PACKAGE_LIST_DIR_PATH}/${REF_PACKAGE_REMOVE_DIR_NAME}"


	##
	## ## Hook / Path
	##

	REF_HOOK_DIR_NAME="hook"
	REF_HOOK_DIR_PATH="${REF_PLAN_FACTORY_DIR_PATH}/${REF_HOOK_DIR_NAME}"


	##
	## ## ISO Template / Path
	##

	REF_ISO_TEMPLATE_SOURCE_DIR_NAME="iso-template"
	REF_ISO_TEMPLATE_SOURCE_DIR_PATH="${REF_PLAN_FACTORY_DIR_PATH}/${REF_ISO_TEMPLATE_SOURCE_DIR_NAME}"


	REF_ISO_TEMPLATE_TARGET_DIR_NAME="binary"
	REF_ISO_TEMPLATE_TARGET_DIR_PATH="${REF_ISO_PROFILE_DIR_PATH}/${REF_ISO_TEMPLATE_TARGET_DIR_NAME}"


	##
	## ## Build Live Config
	##

	REF_BUILD_LIVE_CONFIG_ROOT_DIR_NAME="lingmo-config"
	REF_BUILD_LIVE_CONFIG_ROOT_DIR_PATH="${REF_ISO_PROFILE_DIR_PATH}/${REF_BUILD_LIVE_CONFIG_ROOT_DIR_NAME}"

	REF_BUILD_LIVE_CONFIG_DIR_NAME="common"
	REF_BUILD_LIVE_CONFIG_DIR_PATH="${REF_BUILD_LIVE_CONFIG_ROOT_DIR_PATH}/${REF_BUILD_LIVE_CONFIG_DIR_NAME}"

	##
	## ## Build Live Config / Factory Overlay
	##

	REF_SOURCE_FACTORY_OVERLAY_MASTER_OS_DIR_NAME="overlay"
	REF_SOURCE_FACTORY_OVERLAY_MASTER_OS_DIR_PATH="${REF_PLAN_FACTORY_DIR_PATH}/${REF_SOURCE_FACTORY_OVERLAY_MASTER_OS_DIR_NAME}"

	REF_TARGET_FACTORY_OVERLAY_MASTER_OS_DIR_NAME="includes.chroot_before_packages"
	REF_TARGET_FACTORY_OVERLAY_MASTER_OS_DIR_PATH="${REF_BUILD_LIVE_CONFIG_DIR_PATH}/${REF_TARGET_FACTORY_OVERLAY_MASTER_OS_DIR_NAME}"



	##
	## ## Build Live Config / Overlay
	##

	REF_SOURCE_OVERLAY_MASTER_OS_DIR_NAME="overlay"
	REF_SOURCE_OVERLAY_MASTER_OS_DIR_PATH="${REF_PLAN_ASSET_DIR_PATH}/${REF_SOURCE_OVERLAY_MASTER_OS_DIR_NAME}"

	REF_TARGET_OVERLAY_MASTER_OS_DIR_NAME="includes.chroot_after_packages"
	REF_TARGET_OVERLAY_MASTER_OS_DIR_PATH="${REF_BUILD_LIVE_CONFIG_DIR_PATH}/${REF_TARGET_OVERLAY_MASTER_OS_DIR_NAME}"




	##
	## ## Build Live Config / Package
	##

	REF_SOURCE_OVERLAY_MASTER_PACKAGE_DIR_NAME="package"
	REF_SOURCE_OVERLAY_MASTER_PACKAGE_DIR_PATH="${REF_PLAN_ASSET_DIR_PATH}/${REF_SOURCE_OVERLAY_MASTER_PACKAGE_DIR_NAME}"


	REF_SOURCE_OVERLAY_MASTER_PACKAGE_INSTALL_DIR_NAME="install"
	REF_SOURCE_OVERLAY_MASTER_PACKAGE_INSTALL_DIR_PATH="${REF_SOURCE_OVERLAY_MASTER_PACKAGE_DIR_PATH}/${REF_SOURCE_OVERLAY_MASTER_PACKAGE_INSTALL_DIR_NAME}"

	REF_TARGET_OVERLAY_MASTER_PACKAGE_INSTALL_DIR_NAME="package-lists"
	REF_TARGET_OVERLAY_MASTER_PACKAGE_INSTALL_DIR_PATH="${REF_BUILD_LIVE_CONFIG_DIR_PATH}/${REF_TARGET_OVERLAY_MASTER_PACKAGE_INSTALL_DIR_NAME}"




	##
	## ## Build Live Config / Hook
	##

	REF_SOURCE_OVERLAY_MASTER_HOOK_DIR_NAME="hook"
	REF_SOURCE_OVERLAY_MASTER_HOOK_DIR_PATH="${REF_PLAN_FACTORY_DIR_PATH}/${REF_SOURCE_OVERLAY_MASTER_HOOK_DIR_NAME}"

	REF_TARGET_OVERLAY_MASTER_HOOK_DIR_NAME="hooks/normal"
	REF_TARGET_OVERLAY_MASTER_HOOK_DIR_PATH="${REF_BUILD_LIVE_CONFIG_DIR_PATH}/${REF_TARGET_OVERLAY_MASTER_HOOK_DIR_NAME}"




	return 0
}

master_var_dump () {

	is_not_debug && return 0


	util_debug_echo

	util_debug_echo
	util_debug_echo "##"
	util_debug_echo "## ## Dump / master_var_dump"
	util_debug_echo "##"




	##
	## ## Master / Args
	##

	util_debug_echo
	util_debug_echo "DEFAULT_BUILD_ARCH=${DEFAULT_BUILD_ARCH}"
	util_debug_echo "REF_BUILD_ARCH=${REF_BUILD_ARCH}"
	util_debug_echo "REF_BUILD_ARCH_OPTION_LIST=${REF_BUILD_ARCH_OPTION_LIST}"


	##
	## ## Master / Opts
	##

	util_debug_echo
	util_debug_echo "DEFAULT_MAIN_RUN=${DEFAULT_MAIN_RUN}"
	util_debug_echo "REF_MAIN_RUN=${REF_MAIN_RUN}"

	util_debug_echo
	util_debug_echo "DEFAULT_BUILD_LOCALE=${DEFAULT_BUILD_LOCALE}"
	util_debug_echo "REF_BUILD_LOCALE=${REF_BUILD_LOCALE}"
	util_debug_echo "REF_BUILD_LOCALE_OPTION_LIST=${REF_BUILD_LOCALE_OPTION_LIST}"


	##
	## ## ISO Profile / Path
	##

	util_debug_echo
	util_debug_echo "REF_ISO_PROFILE_DIR_NAME=${REF_ISO_PROFILE_DIR_NAME}"
	util_debug_echo "REF_ISO_PROFILE_DIR_PATH=${REF_ISO_PROFILE_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_ISO_PROFILE_REPO_GIT_URL=${REF_ISO_PROFILE_REPO_GIT_URL}"


	##
	## ## Target OS / Path
	##

	util_debug_echo
	util_debug_echo "REF_TARGET_OS_ROOT_DIR_NAME=${REF_TARGET_OS_ROOT_DIR_NAME}"
	util_debug_echo "REF_TARGET_OS_ROOT_DIR_PATH=${REF_TARGET_OS_ROOT_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_TARGET_OS_ARCHIVE_FILE_NAME=${REF_TARGET_OS_ARCHIVE_FILE_NAME}"
	util_debug_echo "REF_TARGET_OS_ARCHIVE_FILE_PATH=${REF_TARGET_OS_ARCHIVE_FILE_PATH}"


	##
	## ## Target OS / debootstrap args
	##

	util_debug_echo
	util_debug_echo "DEFAULT_BUILD_SUITE=${DEFAULT_BUILD_SUITE}"
	util_debug_echo "REF_BUILD_SUITE=${REF_BUILD_SUITE}"

	util_debug_echo
	util_debug_echo "DEFAULT_PACKAGE_REPO_URL=${DEFAULT_PACKAGE_REPO_URL}"
	util_debug_echo "REF_PACKAGE_REPO_URL=${REF_PACKAGE_REPO_URL}"

	util_debug_echo
	util_debug_echo "DEFAULT_BUILD_INCLUDE=${DEFAULT_BUILD_INCLUDE}"
	util_debug_echo "REF_BUILD_INCLUDE=${REF_BUILD_INCLUDE}"


	##
	## ## Overlay / Path
	##

	util_debug_echo
	util_debug_echo "REF_OVERLAY_DIR_NAME=${REF_OVERLAY_DIR_NAME}"
	util_debug_echo "REF_OVERLAY_DIR_PATH=${REF_OVERLAY_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_FACTORY_OVERLAY_DIR_NAME=${REF_FACTORY_OVERLAY_DIR_NAME}"
	util_debug_echo "REF_FACTORY_OVERLAY_DIR_PATH=${REF_FACTORY_OVERLAY_DIR_PATH}"


	##
	## ## Package List / Path
	##

	util_debug_echo
	util_debug_echo "REF_PACKAGE_LIST_DIR_NAME=${REF_PACKAGE_LIST_DIR_NAME}"
	util_debug_echo "REF_PACKAGE_LIST_DIR_PATH=${REF_PACKAGE_LIST_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_PACKAGE_INSTALL_DIR_NAME=${REF_PACKAGE_INSTALL_DIR_NAME}"
	util_debug_echo "REF_PACKAGE_INSTALL_DIR_PATH=${REF_PACKAGE_INSTALL_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_PACKAGE_REMOVE_DIR_NAME=${REF_PACKAGE_REMOVE_DIR_NAME}"
	util_debug_echo "REF_PACKAGE_REMOVE_DIR_PATH=${REF_PACKAGE_REMOVE_DIR_PATH}"


	##
	## ## Hook / Path
	##

	util_debug_echo
	util_debug_echo "REF_HOOK_DIR_NAME=${REF_HOOK_DIR_NAME}"
	util_debug_echo "REF_HOOK_DIR_PATH=${REF_HOOK_DIR_PATH}"


	##
	## ## ISO Template / Path
	##

	util_debug_echo
	util_debug_echo "REF_ISO_TEMPLATE_SOURCE_DIR_NAME=${REF_ISO_TEMPLATE_SOURCE_DIR_NAME}"
	util_debug_echo "REF_ISO_TEMPLATE_SOURCE_DIR_PATH=${REF_ISO_TEMPLATE_SOURCE_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_ISO_TEMPLATE_TARGET_DIR_NAME=${REF_ISO_TEMPLATE_TARGET_DIR_NAME}"
	util_debug_echo "REF_ISO_TEMPLATE_TARGET_DIR_PATH=${REF_ISO_TEMPLATE_TARGET_DIR_PATH}"


	util_debug_echo
	util_debug_echo
	util_debug_echo "##"
	util_debug_echo "## ## Tips"
	util_debug_echo "##"
	util_debug_echo
	util_debug_echo "> Hide Dump Info"
	util_debug_echo
	util_debug_echo "\$ export IS_DEBUG=false"
	util_debug_echo




	return 0
}

master_var_init

master_var_dump




##
## ## Target OS / Util
##

core_chroot_package_control () {

	core_chroot_run apt "$@"

}

core_chroot_run () {

	local rootfs="${REF_TARGET_OS_ROOT_DIR_PATH}"

	local i=1

	for i in {1..5}; do

		sudo env DEBIAN_FRONTEND=noninteractive chroot "${rootfs}" "${@}"

		if [[ $? == 0 ]]; then
			break
		fi

		sleep 1

	done

}

lingmo_target_os_mount_for_chroot () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Mount For Chroot"
	util_error_echo "##"
	util_error_echo

	local rootfs="${REF_TARGET_OS_ROOT_DIR_PATH}"

	core_target_os_mount_for_chroot "${rootfs}"

}

core_target_os_mount_for_chroot () {

	local rootfs="${1}"

	mount --bind /dev "${rootfs}/dev"
	mount --bind /run  "${rootfs}/run"
	#mount --bind /media  "${rootfs}/media"
	mount -t devpts devpts "${rootfs}/dev/pts"
	mount -t sysfs sysfs "${rootfs}/sys"
	mount -t proc proc "${rootfs}/proc"
	mount -t tmpfs tmpfs  "${rootfs}/dev/shm"
	mount --bind /tmp "${rootfs}/tmp"

	return 0
}

lingmo_target_os_unmount_for_chroot () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Unmount For Chroot"
	util_error_echo "##"
	util_error_echo

	local rootfs="${REF_TARGET_OS_ROOT_DIR_PATH}"

	core_target_os_unmount_for_chroot "${rootfs}"

}

core_target_os_unmount_for_chroot () {

	local rootfs="${1}"

	#umount "${rootfs}/sys/firmware/efi/efivars"
	umount "${rootfs}/sys"
	umount "${rootfs}/dev/pts"
	umount "${rootfs}/dev/shm"
	umount "${rootfs}/dev"

	umount "${rootfs}/run"
	#umount "${rootfs}/media"
	umount "${rootfs}/proc"
	umount "${rootfs}/tmp"

	return 0
}


##
## ## Lingmo / Build ISO / Package Required For Build
##

lingmo_build_iso_package_required () {

	#return 0

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Check Package Required"
	util_error_echo "##"
	util_error_echo


	util_error_echo
	util_error_echo "apt-get install live-build -y"
	util_error_echo
	apt-get install live-build -y

	util_error_echo



}


##
## ## Lingmo / Build ISO / Steps
##

lingmo_build_iso_develop_test () {


	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Run / lingmo_build_iso_develop_test"
	util_error_echo "##"
	util_error_echo

	msg_master_args

	lingmo_build_iso_develop_test_prototype

}

lingmo_build_iso_develop_test_prototype () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Run / lingmo_build_iso_develop_test_prototype"
	util_error_echo "##"
	util_error_echo


	#lingmo_build_iso_package_required


	#lingmo_build_iso_create

	#lingmo_build_iso_overlay




	return 0
}


lingmo_build_iso_steps () {


	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Run / lingmo_build_iso_steps"
	util_error_echo "##"
	util_error_echo


	msg_master_args


	lingmo_build_iso_package_required


	lingmo_build_iso_create


	return 0
}


##
## ## Lingmo / Build ISO / Prepare
##

lingmo_build_iso_prepare () {


	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Lingmo / Build ISO / Prepare"
	util_error_echo "##"
	util_error_echo


	lingmo_build_iso_prepare_work_dir
	lingmo_build_iso_prepare_iso_profile


	return 0
}


##
## ## Lingmo / Build ISO / Prepare / Work Dir
##

lingmo_build_iso_prepare_work_dir () {

	local work_dir_path="${REF_PLAN_WORK_DIR_PATH}"


	if [[ -d "${work_dir_path}" ]]; then

		return 0

	fi


	util_error_echo
	util_error_echo mkdir -p "${work_dir_path}"
	util_error_echo
	mkdir -p "${work_dir_path}"


	return 0
}

##
## ## Lingmo / Build ISO / Prepare / ISO Profile
##

lingmo_build_iso_prepare_iso_profile () {

	local iso_profile_repo_git_url="${REF_ISO_PROFILE_REPO_GIT_URL}"
	local iso_profile_dir_path="${REF_ISO_PROFILE_DIR_PATH}"


	if [[ -d "${iso_profile_dir_path}" ]]; then

		#return 0 ## for codeing

		lingmo_target_os_unmount_for_chroot

		util_error_echo
		util_error_echo rm -rf "${iso_profile_dir_path}"
		util_error_echo
		rm -rf "${iso_profile_dir_path}"



	fi


	util_error_echo
	util_error_echo git clone "${iso_profile_repo_git_url}" "${iso_profile_dir_path}"
	util_error_echo
	git clone "${iso_profile_repo_git_url}" "${iso_profile_dir_path}"


	return 0
}


##
## ## Lingmo / Build ISO / Overlay
##

lingmo_build_iso_overlay () {


	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Lingmo / Build ISO / Overlay"
	util_error_echo "##"
	util_error_echo

	lingmo_factory_master_os_file_overlay

	lingmo_master_os_file_overlay

	lingmo_master_os_package_overlay

	lingmo_live_build_config_hook_overlay





	return 0
}


##
## ## Lingmo / Master OS / Factory Overlay
##

lingmo_factory_master_os_file_overlay () {


	local source_dir_path="${REF_SOURCE_FACTORY_OVERLAY_MASTER_OS_DIR_PATH}"
	local target_dir_path="${REF_TARGET_FACTORY_OVERLAY_MASTER_OS_DIR_PATH}"

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Lingmo / Master OS / Factory Overlay"
	util_error_echo "##"
	util_error_echo


	util_error_echo
	util_error_echo mkdir -p "${source_dir_path}"
	mkdir -p "${source_dir_path}"


	util_error_echo
	util_error_echo mkdir -p "${target_dir_path}"
	mkdir -p "${target_dir_path}"


	util_error_echo
	util_error_echo cp -rf "${source_dir_path}/." "${target_dir_path}"
	cp -rf "${source_dir_path}/." "${target_dir_path}"


	return 0
}


##
## ## Lingmo / Master OS / Overlay
##

lingmo_master_os_file_overlay () {


	local source_dir_path="${REF_SOURCE_OVERLAY_MASTER_OS_DIR_PATH}"
	local target_dir_path="${REF_TARGET_OVERLAY_MASTER_OS_DIR_PATH}"

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Lingmo / Master OS / Overlay"
	util_error_echo "##"
	util_error_echo


	util_error_echo
	util_error_echo mkdir -p "${source_dir_path}"
	mkdir -p "${source_dir_path}"


	util_error_echo
	util_error_echo mkdir -p "${target_dir_path}"
	mkdir -p "${target_dir_path}"


	util_error_echo
	util_error_echo cp -rf "${source_dir_path}/." "${target_dir_path}"
	cp -rf "${source_dir_path}/." "${target_dir_path}"


	return 0
}


##
## ## Lingmo / Master OS / Package
##

lingmo_master_os_package_overlay () {


	local source_dir_path="${REF_SOURCE_OVERLAY_MASTER_PACKAGE_INSTALL_DIR_PATH}"
	local target_dir_path="${REF_TARGET_OVERLAY_MASTER_PACKAGE_INSTALL_DIR_PATH}"

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Lingmo / Master OS / Package"
	util_error_echo "##"
	util_error_echo


	util_error_echo
	util_error_echo mkdir -p "${source_dir_path}"
	mkdir -p "${source_dir_path}"


	util_error_echo
	util_error_echo mkdir -p "${target_dir_path}"
	mkdir -p "${target_dir_path}"


	util_error_echo
	util_error_echo cp -rf "${source_dir_path}/." "${target_dir_path}"
	cp -rf "${source_dir_path}/." "${target_dir_path}"


	return 0
}


##
## ## Lingmo / Live Build Config / Hook
##

lingmo_live_build_config_hook_overlay () {


	local source_dir_path="${REF_SOURCE_OVERLAY_MASTER_HOOK_DIR_PATH}"
	local target_dir_path="${REF_TARGET_OVERLAY_MASTER_HOOK_DIR_PATH}"

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Lingmo / Master OS / Hook"
	util_error_echo "##"
	util_error_echo


	util_error_echo
	util_error_echo mkdir -p "${source_dir_path}"
	mkdir -p "${source_dir_path}"


	util_error_echo
	util_error_echo mkdir -p "${target_dir_path}"
	mkdir -p "${target_dir_path}"


	util_error_echo
	util_error_echo cp -rf "${source_dir_path}/." "${target_dir_path}"
	cp -rf "${source_dir_path}/." "${target_dir_path}"


	return 0
}


##
## ## Lingmo / Build ISO / Archive
##

lingmo_build_iso_archive () {


	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Lingmo / Build ISO / Archive / Start"
	util_error_echo "##"
	util_error_echo


	local iso_profile_dir_path="${REF_ISO_PROFILE_DIR_PATH}"

	local build_arch="${REF_BUILD_ARCH}"
	local build_agent_file_name="build.sh"
	local build_agent="./${build_agent_file_name}"
	local build_agent_file_path="${iso_profile_dir_path}/${build_agent_file_name}"


	##
	## ## iso build head
	##
	util_error_echo
	util_error_echo cd "${iso_profile_dir_path}"
	cd "${iso_profile_dir_path}"


	##
	## ## iso build start
	##
	util_error_echo
	util_error_echo "${build_agent}"
	util_error_echo
	"${build_agent}"


	##
	## ## iso build tail
	##
	util_error_echo
	util_error_echo "cd ${OLDPWD}"
	cd "${OLDPWD}"




	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Lingmo / Build ISO / Archive / Done"
	util_error_echo "##"
	util_error_echo


	return 0
}


##
## ## Lingmo / Build ISO / Create
##

lingmo_build_iso_create () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Lingmo / Build ISO / Create"
	util_error_echo "##"
	util_error_echo


	##
	## ## prepare
	##
	lingmo_build_iso_prepare


	##
	## ## overlay
	##
	lingmo_build_iso_overlay


	##
	## ## create iso
	##
	lingmo_build_iso_archive


	return 0
}


##
## ## Lingmo / Build ISO / Start
##

lingmo_build_iso_start () {

	main_signal_bind

	limit_root_user_required


	local main_run="${REF_MAIN_RUN}"

	if [[ "${main_run}" == "test" ]]; then
		lingmo_build_iso_develop_test
	else
		lingmo_build_iso_steps
	fi


	return 0
}


##
## ## Limit / Root User Required
##

limit_root_user_required () {

	if [[ "${EUID}" == 0 ]]; then

		return 0

	else

		util_error_echo
		util_error_echo "##"
		util_error_echo "## ## Root User Required"
		util_error_echo "##"

		util_error_echo
		util_error_echo "> Please Run As Root"
		util_error_echo
		util_error_echo "Example: sudo ./${REF_CMD_FILE_NAME} amd64"
		util_error_echo

		#sleep 2
		exit 0
	fi

}


##
## ## Main / Signal
##

exit_on_signal_interrupted () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## **Script Interrupted**"
	util_error_echo "##"
	util_error_echo

	## TODO:

	sleep 2


	exit 0

}

exit_on_signal_terminated () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## **Script Terminated**"
	util_error_echo "##"
	util_error_echo

	## TODO:

	sleep 2


	exit 0

}

main_signal_bind () {

	trap exit_on_signal_interrupted SIGINT
	trap exit_on_signal_terminated SIGTERM

}


##
## ## Msg / Help
##

msg_help_build_arch_required () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Build Arch Required"
	util_error_echo "##"

	util_error_echo
	msg_usage_body_main
	util_error_echo

}

msg_help_build_arch_not_supported () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Build Arch Not Supported"
	util_error_echo "##"

	util_error_echo
	msg_usage_body_main
	util_error_echo

}

msg_help_build_locale_not_supported () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Build Locale Not Supported"
	util_error_echo "##"

	util_error_echo
	msg_usage_body_locale
	util_error_echo

}

msg_usage_body_main () {


	util_error_echo "> Build Arch Options: ${REF_BUILD_ARCH_OPTION_LIST}"
	util_error_echo
	util_error_echo "SYNOPSIS : sudo ./${REF_CMD_FILE_NAME} [build_arch]"
	util_error_echo
	util_error_echo "Example  : sudo ./${REF_CMD_FILE_NAME} amd64"
	util_error_echo
	util_error_echo "Example  : sudo ./${REF_CMD_FILE_NAME} amd64"
	util_error_echo
	util_error_echo "Example  : sudo ./${REF_CMD_FILE_NAME} unstable"


	return 0
}

msg_usage_body_locale () {


	util_error_echo "> Build Locale Options: ${REF_BUILD_LOCALE_OPTION_LIST}"
	util_error_echo
	util_error_echo "SYNOPSIS : sudo REF_BUILD_LOCALE=zh_tw ./${REF_CMD_FILE_NAME} [build_arch]"
	util_error_echo
	util_error_echo "Example  : sudo REF_BUILD_LOCALE=zh_tw ./${REF_CMD_FILE_NAME} amd64"
	util_error_echo
	util_error_echo "Example  : sudo REF_BUILD_LOCALE=ez_cn ./${REF_CMD_FILE_NAME} amd64"


	return 0
}


##
## ## Msg / Args
##

msg_master_args () {

	util_error_echo
	util_error_echo "Build: REF_BUILD_ARCH=${REF_BUILD_ARCH}"
	util_error_echo "Build: REF_BUILD_LOCALE=${REF_BUILD_LOCALE}"
	util_error_echo

	return 0
}

##
## ## Master / Args
##

master_arg_build_arch () {

	util_debug_echo
	util_debug_echo "Arg: 1=${1}"

	REF_BUILD_ARCH="${1}"


	if [[ -z "${REF_BUILD_ARCH}" ]]; then
		REF_BUILD_ARCH="${DEFAULT_BUILD_ARCH}"
	fi


	local not_allowed="true"
	local allow_build_arch=""

	for allow_build_arch in ${REF_BUILD_ARCH_OPTION_LIST}; do

		if [[ "${allow_build_arch}" == "${REF_BUILD_ARCH}" ]]; then

			util_debug_echo "allow_build_arch=${allow_build_arch}"
			not_allowed="false"
			break;

		fi

	done


	if [[ "${not_allowed}" == "true" ]]; then
		util_debug_echo "Var: REF_BUILD_ARCH=${REF_BUILD_ARCH}"

		msg_help_build_arch_not_supported

		util_error_echo "Arg: 1=${1}"
		util_error_echo "Var: REF_BUILD_ARCH=${REF_BUILD_ARCH}"
		exit;
	fi


	util_debug_echo "Var: REF_BUILD_ARCH=${REF_BUILD_ARCH}"

	return 0
}

master_arg_build_locale () {

	util_debug_echo


	if [[ -z "${REF_BUILD_LOCALE}" ]]; then
		REF_BUILD_LOCALE="${DEFAULT_BUILD_LOCALE}"
	fi


	local not_allowed="true"
	local allow_build_locale=""

	for allow_build_locale in ${REF_BUILD_LOCALE_OPTION_LIST}; do

		if [[ "${allow_build_locale}" == "${REF_BUILD_LOCALE}" ]]; then

			util_debug_echo "allow_build_locale=${allow_build_locale}"
			not_allowed="false"
			break;

		fi

	done


	if [[ "${not_allowed}" == "true" ]]; then

		util_debug_echo "Var: REF_BUILD_LOCALE=${REF_BUILD_LOCALE}"

		msg_help_build_locale_not_supported

		util_error_echo "Var: REF_BUILD_LOCALE=${REF_BUILD_LOCALE}"
		exit;

	fi


	util_debug_echo "Var: REF_BUILD_LOCALE=${REF_BUILD_LOCALE}"

	return 0
}


##
## ## Main / Args
##

_main_check_args_size_ () {

	local args_size="${1}"

	if [[ ${1} -le 0 ]]; then

		msg_help_build_arch_required

		exit 1

	fi

}

_main_init_args_ () {

	##
	## Example: `sudo ./steps.sh amd64`
	##

	util_debug_echo
	util_debug_echo "##"
	util_debug_echo "## ## Args / Init"
	util_debug_echo "##"


	master_arg_build_arch "${@}"

	master_arg_build_locale "${@}"


	util_debug_echo

	return 0
}


##
## ## Main / Start
##

__main__ () {

	lingmo_build_iso_start "${@}"

}

_main_check_args_size_ "${#}"

_main_init_args_ "${@}"

__main__ "${@}"
