# shellcheck shell=bash
# shellcheck disable=SC2034

## Include Guard to prevent multiple sourcing
if [ -n "${INCLUDE_GUARD_DOCKER_HACKMD_NO_CDN}" ]; then
	return 0
fi

HMD_USECDN=false; export HMD_USECDN

## Set Include Guard
declare INCLUDE_GUARD_DOCKER_HACKMD_NO_CDN=1

## This script is based on the GNU Bash Shell Script Template project
## https://github.com/Lin-Buo-Ren/GNU-Bash-Shell-Script-Template
## and is based on the following version:
## META_BASED_ON_GNU_BASH_SHELL_SCRIPT_TEMPLATE_VERSION="v2.0.1-2-g877ada8-dirty"
## You may rebase your script to incorporate new features and fixes from the template