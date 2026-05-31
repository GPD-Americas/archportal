#!/usr/bin/env bash
set -euo pipefail

# Functions used below defined in this script
source archlandia_helpers.sh

# Indicator that Archl
ARCHLANDIA_MARKER="$HOME/.local/share/archlandia/created"

# Flag indicating if installing from Linux4Tegra Ubuntu
TEGRA=0


# If an argument has been provided, set TEGRA, warning if not --tegra
for arg in "$@"; do
    case "$arg" in
        --tegra)
            TEGRA=1
            ;;
        *)
            warn "unknown arg: $arg"
            ;;
    esac
done

# Install from Tegra if requested
if [ "$TEGRA" -eq 1 ]; then
    create_archlandia_tegra
    exit 0
fi

# Install from Arch Linux itself if not from L4T Ubuntu
if is_created; then
    inspect_archlandia
else
    warn "Archlândia not yet created"

    read -r -p "Create Archlândia now? [y/N] " ans

    case "$ans" in
        y|Y|yes|YES)
            create_archlandia
            inspect_archlandia
            ;;
        *)
            warn "Not creating Archlreation skipped"
            ;;
    esac
fi
