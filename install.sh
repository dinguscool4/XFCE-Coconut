#!/usr/bin/env bash

set -euo pipefail

echo "Installing XFCE-Coconut"

sudo pacman -S --needed --noconfirm xorg-server xfce4 xfce4-goodies lightdm lightdm-gtk-greeter pipewire pipewire-alsa pipewire-pulse wireplumber alsa-utils networkmanager network-manager-applet xdg-user-dirs

xdg-user-dirs-update

sudo systemctl enable lightdm

sudo systemctl enable NetworkManager

set_xfconf() {
    if [ -n "${DBUS_SESSION_BUS_ADDRESS:-}" ]; then
        xfconf-query -c "$1" -p "$2" -n -t "$3" -s "$4"
    else
        dbus-run-session -- xfconf-query -c "$1" -p "$2" -n -t "$3" -s "$4"
    fi
}

set_xfconf xsettings /Net/ThemeName string "HighContrast"
set_xfconf xsettings /Net/IconThemeName string "elementary-xfce"
set_xfconf xsettings /Gtk/CursorThemeName string "elementary"
set_xfconf xsettings /Gtk/CursorThemeSize int 16

set_xfconf xfwm4 /general/workspace_count int 3

cp -r "$(dirname "$0")/.config" ~/
