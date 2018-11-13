# shellcheck shell=bash
# shellcheck disable=SC2034

# Linuxbrew post installation setup
# 林博仁 © 2018

## Include Guard to prevent multiple sourcing
if [ -n "${_PROFILE_D_INC_GRD_LINUXBREW}" ]; then
	return 0
fi

if test -d /home/linuxbrew; then
	export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
	export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
	export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
fi

## Set Include Guard
_PROFILE_D_INC_GRD_LINUXBREW=1

