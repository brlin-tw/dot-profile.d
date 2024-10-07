#!/usr/bin/env bash
# Install the product into the user's environment
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: GPL-3.0-or-later

printf \
    'Info: Configuring the defensive interpreter behaviors...\n'
set_opts=(
    # Terminate script execution when an unhandled error occurs
    -o errexit
    -o errtrace

    # Terminate script execution when an unset parameter variable is
    # referenced
    -o nounset
)
if ! set "${set_opts[@]}"; then
    printf \
        'Error: Unable to configure the defensive interpreter behaviors.\n' \
        1>&2
    exit 1
fi

printf \
    'Info: Setting the ERR trap...\n'
trap_err(){
    printf \
        'Error: The program prematurely terminated due to an unhandled error.\n' \
        1>&2
    exit 99
}
if ! trap trap_err ERR; then
    printf \
        'Error: Unable to set the ERR trap.\n' \
        1>&2
    exit 1
fi

printf \
    'Info: Checking the existence of the required commands...\n'
required_commands=(
    # For determining the operation timestamp
    date

    # For determine whether the setup logic exist in the user's profile
    # configuration file
    grep

    # For installing product files to the system
    install

    # For determining the absolute path of the script
    realpath

    # For patching the existing setup logic in the user's profile configuration
    # file
    sed
)
flag_required_command_check_failed=false
for command in "${required_commands[@]}"; do
    if ! command -v "${command}" >/dev/null; then
        flag_required_command_check_failed=true
        printf \
            'Error: This program requires the "%s" command to be available in your command search PATHs.\n' \
            "${command}" \
            1>&2
    fi
done
if test "${flag_required_command_check_failed}" == true; then
    printf \
        'Error: Required command check failed, please check your installation.\n' \
        1>&2
    exit 1
fi

printf \
    'Info: Configuring the convenience variables...\n'
if test -v BASH_SOURCE; then
    # Convenience variables may not need to be referenced
    # shellcheck disable=SC2034
    {
        printf \
            'Info: Determining the absolute path of the program...\n'
        if ! script="$(
            realpath \
                --strip \
                "${BASH_SOURCE[0]}"
            )"; then
            printf \
                'Error: Unable to determine the absolute path of the program.\n' \
                1>&2
            exit 1
        fi
        script_dir="${script%/*}"
        script_filename="${script##*/}"
        script_name="${script_filename%%.*}"
    }
fi
# Convenience variables may not need to be referenced
# shellcheck disable=SC2034
{
    script_basecommand="${0}"
    script_args=("${@}")
}

printf \
    'Info: Determining operation timestamp...\n'
if ! operation_timestamp="$(date +%Y%m%d-%H%M%S)"; then
    printf \
        'Error: Unable to determine the operation timestamp.\n' \
        1>&2
    exit 2
fi

user_profile_dropin_dir="${HOME}/.profile.d"
if ! test -e "${user_profile_dropin_dir}"; then
    install_opts=(
        --directory
        --mode 0755
        --verbose
    )
    printf \
        'Info: Creating the user profile drop-in directory...\n'
    if ! install "${install_opts[@]}" "${user_profile_dropin_dir}"; then
        printf \
            'Error: Unable to create the user profile drop-in directory.\n' \
            1>&2
        exit 2
    fi
fi

product_dir="${script_dir}"
product_assets=(
    "${product_dir}/README"*.md
    "${product_dir}/.setup.source.sh"
    "${product_dir}/.functions.source.sh"
    "${product_dir}/install-executable-search-path.source.sh.template"

    # For ease of editing product files
    "${product_dir}/.editorconfig"
)

for asset in "${product_assets[@]}"; do
    asset_filename="${asset##*/}"
    printf \
        'Info: Installing the "%s" product asset...\n' \
        "${asset_filename}"
    install_opts=(
        --target-directory="${user_profile_dropin_dir}"
        --mode=0644
    )
    if ! install "${install_opts[@]}" "${asset}"; then
        printf \
            'Error: Unable to install the "%s" product asset.\n' \
            "${asset_filename}" \
            1>&2
        exit 2
    fi
done

obsoleted_assets=(
    "${user_profile_dropin_dir}/README.setup"
    "${user_profile_dropin_dir}/setup.sh.source"
    "${user_profile_dropin_dir}/README.functions"
    "${user_profile_dropin_dir}/functions.sh.source"
)
for asset in "${obsoleted_assets[@]}"; do
    asset_filename="${asset##*/}"
    if test -e "${asset}"; then
        printf \
            'Info: Removing the "%s" obsoleted product asset...\n' \
            "${asset_filename}"
        rm_opts=(
            --verbose
        )
        if ! rm "${rm_opts[@]}" "${asset}"; then
            printf \
                'Error: Unable to remove the "%s" obsoleted product asset...\n' \
            "${asset_filename}" \
            1>&2
        fi
    fi
done

# Check whether the setup logic is available in the user profile configuration
# file
is_setup_logic_installed(){
    local user_profile="${1}"; shift

    if ! test -e "${user_profile}"; then
        return 1
    fi

    # FALSE POSITIVE: The parameter expansion-like patterns aren't intend to be
    # expanded at the moment
    # shellcheck disable=SC2016
    local -a grep_opts=(
        # The search patterns specified
        --regexp='. "${HOME}/.profile.d/setup.sh.source"'
        --regexp='. "${HOME}/.profile.d/README.setup"'

        # The search patterns are literal strings, not expression
        --fixed-strings

        # Don't output matched result, only express whether there's a match via
        # process exit status codes
        --quiet
    )
    if ! grep "${grep_opts[@]}" "${user_profile}"; then
        return 1
    else
        return 0
    fi
}
# Check whether the obsolete setup logic is available in the user profile
# configuration file
is_outdated_setup_logic_installed(){
    local user_profile="${1}"; shift

    if ! test -e "${user_profile}"; then
        return 1
    fi

    # FALSE POSITIVE: The parameter expansion-like patterns aren't intend to be
    # expanded at the moment
    # shellcheck disable=SC2016
    local -a grep_opts=(
        # The search patterns specified
        --regexp='. "${HOME}/.profile.d/README.setup"'
        --regexp='. "${HOME}/.profile.d/setup.sh.source"'

        # The search patterns are literal strings, not expression
        --fixed-strings

        # Don't output matched result, only express whether there's a match via
        # process exit status codes
        --quiet
    )
    if ! grep "${grep_opts[@]}" "${user_profile}"; then
        return 1
    else
        return 0
    fi
}

user_profile=~/.profile
if is_setup_logic_installed "${user_profile}"; then
    if is_outdated_setup_logic_installed "${user_profile}"; then
        printf \
            'Info: Updating outdated setup logic...\n'
        # FALSE POSITIVE: The parameter expansion-like pattern of the HOME
        # environment variable isn't intend to be expanded at the moment
        # shellcheck disable=SC2016
        sed_opts=(
            # Rewrite the input file but create backup file with unique timestamp
            # for restoring
            --in-place=".bak.${operation_timestamp}"

            # Input expression is a Extended Regular Expression(ERE)
            --regexp-extended

            # sed expressions to process
            --expression='s@\. "\$\{HOME\}/\.profile\.d/README\.setup"@. "${HOME}/.profile.d/.setup.source.sh"@g'
            --expression='s@\. "\$\{HOME\}/\.profile\.d/setup\.sh\.source"@. "${HOME}/.profile.d/.setup.source.sh"@g'
        )
        if ! sed "${sed_opts[@]}" "${user_profile}"; then
            printf \
                'Error: Unable to update the outdated setup logic.\n' \
                1>&2
            exit 2
        fi
    fi
else
    printf \
        'Info: Installing the setup logic to the user profile configuration file...\n'
    if ! cat >>"${user_profile}" <<EOF
# Setup .profile.d
# https://github.com/brlin-tw/dot-profile.d
. "\${HOME}/.profile.d/.setup.source.sh"

EOF
    then
        printf \
            'Error: Unable to install the setup logic to the user profile configuration file.\n' \
            1>&2
        exit 2
    fi
fi

printf \
    'Info: Operation completed without errors.\n'
