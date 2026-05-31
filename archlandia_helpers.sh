ok()   { printf "\033[1;32m[ok]\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m[!!]\033[0m %s\n" "$*"; }

have() {
    command -v "$1" >/dev/null 2>&1
}

check_cmd() {
    if have "$1"; then
        ok "$1 installed"
    else
        warn "$1 missing"
    fi
}

is_created() {
    [ -f "$ARCHLANDIA_MARKER" ]
}

ask_open_portal() {
    echo
    read -r -p "Should I open the portal now? [y/N] " ans

    case "$ans" in
        y|Y|yes|YES)
            if [ -x ./archportal.sh ]; then
                ./archportal.sh
            elif [ -x ./archportal ]; then
                ./archportal
            else
                warn "portal not found"
            fi
            ;;
    esac
}

create_archlandia() {
    echo
    echo "Creating Archlândia..."
    echo

    sudo pacman -Syu

    sudo pacman -S --needed \
        tmux \
        neovim \
        git \
        rust \
        kitty \
        firefox \
        acpi \
        earlyoom \
        hyprland \
        hyprlock \
        fuzzel

    sudo mkdir -p /swap
    sudo fallocate -l 4G /swap/swapfile
    sudo chmod 600 /swap/swapfile
    sudo mkswap /swap/swapfile
    sudo swapon /swap/swapfile

    sudo systemctl enable --now earlyoom
    sudo timedatectl set-ntp true

    mkdir -p "$(dirname "$ARCHLANDIA_MARKER")"
    date > "$ARCHLANDIA_MARKER"

    ok "Archlândia created"
}

create_archlandia_tegra() {

    ensure_arch_root_mounted

    # Perform the initial 
    arch-chroot "$ARCH_MOUNT" pacman -Syu --noconfirm

    arch-chroot "$ARCH_MOUNT" pacman -S --needed \
        tmux \
        neovim \
        git \
        rust \
        kitty \
        firefox \
        acpi \
        earlyoom \
        hyprland \
        hyprlock \
        fuzzel

    arch-chroot "$ARCH_MOUNT" systemctl enable earlyoom

    touch "$ARCH_MOUNT/home/$USER/.local/share/archlandia/created"
}


inspect_archlandia() {
    echo
    echo "Archlândia"
    echo "=========="
    echo

    echo "Time"
    echo "----"
    timedatectl | sed 's/^/  /'

    echo
    echo "Locale"
    echo "------"
    localectl status | sed 's/^/  /'

    echo
    echo "Core"
    echo "----"
    check_cmd tmux
    check_cmd nvim
    check_cmd git
    check_cmd cargo

    echo
    echo "Battery"
    echo "-------"
    check_cmd acpi

    if have acpi; then
        acpi -b | sed 's/^/  /'
    fi

    echo
    echo "Memory"
    echo "------"
    check_cmd earlyoom

    echo
    echo "Graphics"
    echo "--------"
    check_cmd Hyprland
    check_cmd hyprctl
    check_cmd kitty
    check_cmd firefox

    echo
    ok "inspection complete"
}
