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


# Mount Arch Linux root
printf "*** Mounting Arch Linux partition if not mounted..."
mountpoint -q $ARCH_MOUNT || sudo mount $ARCH_PHYSICAL $ARCH_MOUNT
printf "Done. ***\n\n"


# Print portal art...
clear
envsubst < portal_art.txt 


# ...and prompt user to enter
read -p "Step through the portal? [Y/n] " answer
answer=${answer:-Y}
case "$answer" in [Yy]|[Yy][Ee][Ss])
		printf "\n\nEnjoy!\n\n"
		;;
	*)
		printf "\n\nNo? Maybe next time...\n\n"
		exit 1
		;;
esac


# Shut down Ubuntu's graphics process, GNOME, etc
printf "*** Stopping GDM... "
sudo systemctl stop gdm || true
printf "Done. Bye! ***\n\n"


# Log in to Arch Linux 
sudo arch-chroot $ARCH_MOUNT /bin/bash -lc 'su - kirby && fish'


#===== POST-ARCH, BACK IN UBUNTU =====##

# When done in Arch, unmount its root
sudo umount $ARCH_MOUNT || true
