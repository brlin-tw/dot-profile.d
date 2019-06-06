# shellcheck shell=bash
# shellcheck disable=SC2034

# Snapcraft-specific settings
# 林博仁(Buo-ren, Lin) © 2018

## Include Guard to prevent multiple sourcing
if [ -n "${_PROFILE_D_INC_GRD_SNAPCRAFT}" ]; then
	return 0
fi

# Hardcode build environment
#SNAPCRAFT_BUILD_ENVIRONMENT=
#export SNAPCRAFT_BUILD_ENVIRONMENT

## Set Include Guard
declare _PROFILE_D_INC_GRD_SNAPCRAFT=1
