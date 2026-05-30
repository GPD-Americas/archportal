#!/usr/bin/env  sh
#
# Author: Matt Turner <https://mat.phd>
# Date: 27 May 2026
#

set -euo pipefail

source set_env.sh

source portal_art.sh

# Double check that relevant dirs are 
for dir in "" dev proc sys run; do
	umount --bind "$ARCH_MOUNT/$dir" || true
done

# Shut down Ubuntu's graphics process, GNOME, etc
systemctl stop gdm || true

mount $ARCH_PHYSICAL $ARCH_MOUNT

for dir in dev proc sys run; do
	mount --bind "$ARCH_MOUNT/$dir" || true
done

sudo arch-chroot $ARCH_MOUNT

for dir in dev proc sys run; do
	umount --bind "$ARCH_MOUNT/$dir" || true
done

umount $ARCH_MOUNT
