#!/bin/bash

set -ouex pipefail

dnf5 install -y tmux niri sddm alacritty firefox dolphin NetworkManager NetworkManager-tui fuzzel wofi swayidle swaylock swaybg qt6ct brightnessctl pipewire wireplumber emacs-nox neovim entr qemu virt-manager

systemctl enable podman.socket
systemctl enable NetworkManager.service
systemctl enable libvirtd.service
systemctl enable sddm.service
