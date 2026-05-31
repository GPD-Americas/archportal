#!/usr/bin/env bash
#
# Create an Archlândia in Arch Linux itself, or from
# the Linux 4 Tegra (L4T) Ubuntu that is standard on
# NVIDIA Jetson hardware. Developed on Jetson Orin Nano.
#
# Author: Matt Turner (matt@mat.phd)
# Date: 30 May 2026
#

set -euo pipefail

# Functions used below defined in this script
source archlandia_helpers.sh

# Indicator that Archl
ARCHLANDIA_MARKER="$HOME/.local/share/archlandia/created"

# Flag indicating if installing from Linux4Tegra Ubuntu
TEGRA=0


# Set TEGRA environment variable if given
for arg in "$@"; do

    case "$arg" in
        # If --tegra provided, set TEGRA
        --tegra)
            TEGRA=1
            ;;
        # If any other arg provided warn user and continue
        *)
            warn "unknown arg: $arg"
            ;;
    esac
done

# Install from Tegra if requested
if [ "$TEGRA" -eq 1 ]; then

    create_archlandia_tegra

    # Exit cleanly (0=no error)
    exit 0
fi

# If not on L4T and Archlândia exists, report inspection
if is_created; then
    inspect_archlandia
    
# If not on L4T w/o Archlândia, prompt to install 
else

    warn "Archlândia not yet created"
    read -r -p "Create Archlândia now? [y/N] " ans

    case "$ans" in
        # Create and inspect if user agrees
        y|Y|yes|YES)
            create_archlandia
            inspect_archlandia
            ;;
        # Otherwise inform no install
        *)
            warn "Not creating an Archlândia at this time."
            ;;
    esac
fi
