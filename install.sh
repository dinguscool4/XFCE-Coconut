#!/usr/bin/env bash

set -euo pipefail

echo "Installing XFCE-Coconut"

sudo pacman -S --needed xorg-server xfce4 xfce4-goodies lightdm lightdm-gtk-greeter

sudo pacman -S --needed pipewire pipewire-alsa pipewire-pulse wireplumber pavucontrol

sudo pacman -S --needed networkmanager network-manager-applet

sudo pacman -S --needed gvfs file-roller xdg-user-dirs ttf-dejavu noto-fonts

xdg-user-dirs-update

sudo systemctl enable lightdm
sudo systemctl enable NetworkManager
