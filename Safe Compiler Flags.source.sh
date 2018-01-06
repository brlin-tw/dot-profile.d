# shellcheck shell=sh
# shellcheck disable=SC2034

# Safe Compiler Flags(orig. Safe CFLAGS)
# https://wiki.gentoo.org/wiki/Safe_CFLAGS
# 林博仁 <Buo.Ren.Lin@gmail.com> © 2017
if [ -n "${INCLUDE_GUARD_PROFILE_D_SAFE_CFLAGS}" ]; then
	return 0
fi

export CFLAGS="-O2 -pipe -march=native"
export CXXFLAGS="${CFLAGS}"

## Set Include Guard
export INCLUDE_GUARD_PROFILE_D_SAFE_CFLAGS=set

## This script is based on the GNU Bash Shell Script Template project
## https://github.com/Lin-Buo-Ren/GNU-Bash-Shell-Script-Template
## and is based on the following version:
# META_BASED_ON_GNU_BASH_SHELL_SCRIPT_TEMPLATE_VERSION="v1.24.2-3-g3ec093a-dirty"
## You may rebase your script to incorporate new features and fixes from the template