#!/usr/bin/env bash
#
# set_env.sh
#
# Set environment variables for the ArchPortal application.
#
# Author: Matt Turner <https://mat.phd>
# Date: 27 May 2026
#

set -euo pipefail


# Physical disk location of the Arch Linux OS root and where we will mount it for chroot
export ARCH_PHYSICAL=/dev/nvme0n1p16
export ARCH_MOUNT=/mnt/arch


## COLORS
export _BLUE=$'\033[1;34m'
export _LIGHT_CYAN=$'\033[1;36m'
export NC=$'\033[0m'  # No color

## COLOR MAPPINGS
export PORTBORDER=${_LIGHT_CYAN}
export ABLUE=${_BLUE}
export BOX=${_BLUE}
export AP=${_LIGHT_CYAN}
export PERSON=${NC}
