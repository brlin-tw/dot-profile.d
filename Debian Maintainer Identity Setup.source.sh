# Setup identity of a Debian Maintainer(require customizing)
# shellcheck shell=bash
# shellcheck disable=SC2034
# 林博仁 © 2017
## Include Guard to prevent multiple sourcing
if [ ! -z "${DEBIAN_MAINTAINER_IDENTITY_SETUP}" ]; then
	return 0
fi

DEBFULLNAME="林博仁 (Buo-Ren, Lin)"
DEBEMAIL="Buo.Ren.Lin@gmail.com"
export\
	DEBFULLNAME\
	DEBEMAIL

## Set Include Guard
DEBIAN_MAINTAINER_IDENTITY_SETUP=1

## This script is based on the GNU Bash Shell Script Template project
## https://github.com/Lin-Buo-Ren/GNU-Bash-Shell-Script-Template
## and is based on the following version:
META_BASED_ON_GNU_BASH_SHELL_SCRIPT_TEMPLATE_VERSION="v1.24.2-3-g3ec093a-dirty"
## You may rebase your script to incorporate new features and fixes from the template
