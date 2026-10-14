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

git clone --depth 1 https://github.com/dinguscool4/XFCE-Coconut.git /tmp/xfce-coconut
cp -r /tmp/xfce-coconut/.config ~/

for m in 0 1 2 3 Virtual-1 Virtual-2 VGA-1 HDMI-1 HDMI-2 DP-1 DP-2 eDP-1 LVDS-1; do
    for w in 0 1 2; do
        set_xfconf xfce4-desktop "/backdrop/screen0/monitor$m/workspace$w/last-image" string /usr/share/backgrounds/xfce/xfce-teal.svg
        set_xfconf xfce4-desktop "/backdrop/screen0/monitor$m/workspace$w/image-style" int 5
    done
done
