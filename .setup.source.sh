# Setup script for .profile.d, source it in .profile
# shellcheck shell=sh
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: GPL-3.0-or-later

## Set to 1 to enable verbose debugging
_PROFILE_D_DEBUG=0

if [ "$_PROFILE_D_DEBUG" = 1 ]; then
    printf --\
        ".profile.d: DEBUG: Loading...\n"\
        1>&2
fi

# Source utility functions
. "${HOME}/.profile.d/.functions.source.sh"

# Source every profile script in ~/.profile.d
if [ -d "${HOME}/.profile.d" ]; then
    for script_source in "${HOME}/.profile.d"/*.source.sh; do
        # If the filename expansion results in no files the expansion pattern will be keep intact and will be an invalid loop item
        if test "${script_source}" = "${HOME}/.profile.d/*.source.sh"; then
            break
        fi

        profile_script="${script_source}"
        profile_script_filename="${script_source##*/}"
        if [ "$_PROFILE_D_DEBUG" = 1 ]; then
            printf --\
                "%s: DEBUG: Sourcing the %s profile script...\n"\
                ".profile.d"\
                "${profile_script_filename}"\
                1>&2
        fi

        # FALSE POSITIVE: External resource
        # shellcheck source=/dev/null
        . "${profile_script}"
    done
fi
