#!/bin/bash

set -ouex pipefail

dnf5 install -y tmux niri sddm alacritty firefox dolphin NetworkManager fuzzel wofi swayidle swaylock swaybg qt6ct brightnessctl pipewire wireplumber emacs-nox neovim entr

copr_install_isolated() {
    local copr_name="$1"
    shift
    local packages=("$@")

    if [[ ${#packages[@]} -eq 0 ]]; then
        echo "ERROR: No packages specified for copr_install_isolated"
        return 1
    fi

    repo_id="copr:copr.fedorainfracloud.org:${copr_name//\//:}"

    echo "Installing ${packages[*]} from COPR $copr_name (isolated)"

    dnf5 -y copr enable "$copr_name"
    dnf5 -y copr disable "$copr_name"
    dnf5 -y install --enablerepo="$repo_id" "${packages[@]}"

    echo "Installed ${packages[*]} from $copr_name"
}

copr_install_isolated "ublue-os/packages" \
    "ublue-bling" \
    "ublue-brew" \
    "ublue-fastfetch" \
    "ublue-polkit-rules" \
    "ublue-setup-services" \
    "uupd"

systemctl enable podman.socket
systemctl enable NetworkManager.service
systemctl enable sddm.service
