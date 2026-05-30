#!/usr/bin/env bash
#
# Author: Matt Turner <https://mat.phd>
# Date: 27 May 2026
#

set -euo pipefail


# Require sudo
sudo -v || exit 1

# Load definitions of the physical and mount locations of Arch
source set_env.sh
printf "*** Mounting Tegra/Ubuntu kernel partitions if not mounted... "
for dir in dev proc sys run; do
	MOUNT_POINT="$ARCH_MOUNT/$dir"
	sudo mkdir -p $MOUNT_POINT
	mountpoint -q $MOUNT_POINT || sudo mount --bind "/$dir" $MOUNT_POINT
done
printf "...Done. ***\n\n"

sudo chroot /mnt/arch/
