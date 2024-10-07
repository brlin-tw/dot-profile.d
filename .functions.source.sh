# utility functions
# shellcheck shell=sh
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: GPL-3.0-or-later

## Include guard
if [ -n "${_PROFILE_D_FUNCTIONS_INCLUDED}" ]; then
    return 0
fi

tmp_dir="$(
    mktemp \
        --directory \
        --tmpdir \
        profile.d.XXXXXX
)"

message_print_error_argument_quantity_mismatch(){
    if [ "${#}" -ne 2 ]; then
        printf "ERROR: message_print_error_argument_quantity_mismatch: %u: Function argument quantity mismatch!\n" "${LINENO}" 1>&2
        return 1
    else
        function_name="${1}"; shift

        # Pass shell-given "${LINENO}"
        # KNOWN ISSUE: Currently Dash doesn't properly implement ${LINENO}, which always evaluates to 0
        #842242 - dash: Missing $LINENO support avoids using dash for autotools ./configure scripts - Debian Bug report logs
        #https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=842242
        line_number="${1}"

        printf "ERROR: %s: %u: Argument quantity mismatch!\n" "${function_name}" "${line_number}" 1>&2

        return 0
    fi
}

## User-friendly directory existance check
is_path_exist(){
    if [ "${#}" -ne 1 ]; then
        message_print_error_argument_quantity_mismatch "is_path_exist" "${LINENO}"
        exit 1
    fi

    test -d "${1}"
    return
}

## Check if the dir is already in ${PATH}
is_dir_in_executable_search_path(){
    if [ "${#}" -ne 1 ]; then
        message_print_error_argument_quantity_mismatch "is_dir_in_executable_search_path" "${LINENO}"
        exit 1
    fi

    is_dir_in_path_dir="${1}"

    find_result=1 # not found by default

    # Backup IFS and restore afterwards
    IFS_ORIGINAL="${IFS}"
    IFS=":"

    for pathdir in ${PATH}; do
        if [ "${is_dir_in_path_dir}" = "${pathdir}" ]; then
            find_result=0
            break
        fi
    done

    IFS="${IFS_ORIGINAL}"

    return "${find_result}"
}

## Utility function to install non-FHS compliant software's executable path to executable search path set
install_executable_search_path(){
    if [ "${#}" -ne 1 ]; then
        message_print_error_argument_quantity_mismatch "install_executable_search_path" "${LINENO}"
        exit 1
    fi

    executable_path="${1}"

    if is_dir_in_executable_search_path "${executable_path}"; then
        return 0
    fi

    if is_path_exist "${executable_path}"; then
        PATH="${executable_path}:${PATH}"
    else
        printf -- \
            "WARNING: %u: Executable path \"%s\" not exist, ignored.\n" \
            "${LINENO}" \
            "${executable_path}" \
            >>"${tmp_dir}"/log
    fi

    unset executable_path
    return 0
}

# Check if the dir is already in paths
#
# Positional parameters:
#
# 1. dir: Directory to check existence
# 2. paths: The PATHs variable to check
#
# Return values:
#
# * 0: `dir` exists in `paths`
# * 1: `dir` not exist in `paths`
# * 2: Error occurred
is_dir_in_paths(){
    if test "${#}" -ne 2; then
        printf \
            'is_dir_in_paths: Error: This function should have 2 arguments, only %s is specified.\n' \
            "${#}" \
            1>&2
        return 2
    fi

    dir="${1}"; shift
    paths="${1}"; shift

    # Backup IFS
    IFS_ORIGINAL="${IFS}"
    IFS=":"

    path_found=false
    for path in ${paths}; do
        if [ "${dir}" = "${path}" ]; then
            path_found=true
            break
        fi
    done

    # Restore IFS
    IFS="${IFS_ORIGINAL}"

    if test "${path_found}" = false; then
        return 1
    else
        return 0
    fi
}

## Set include guard
readonly _PROFILE_D_FUNCTIONS_INCLUDED="1"
