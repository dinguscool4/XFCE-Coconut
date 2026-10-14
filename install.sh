#!/usr/bin/env bash

set -euo pipefail

echo "Installing XFCE-Coconut"

sudo pacman -S --needed xorg-server xfce4 xfce4-goodies lightdm lightdm-gtk-greeter pipewire pipewire-alsa pipewire-pulse wireplumber alsa-utils networkmanager network-manager-applet

xdg-user-dirs-update

sudo systemctl enable lightdm
sudo systemctl enable NetworkManager

set_xfconf() { xfconf-query -c "$1" -p "$2" -n -t "$3" -s "$4"; }

set_xfconf xsettings /Net/ThemeName       string "HighContrast"
set_xfconf xsettings /Net/IconThemeName   string "elementary-xfce"
set_xfconf xsettings /Gtk/CursorThemeName string "elementary"
set_xfconf xsettings /Gtk/CursorThemeSize int    16

set_xfconf xfwm4 /general/workspace_count int 3

K=xfce4-keyboard-shortcuts
set_xfconf $K "/commands/custom/<Super>Return"          string "exo-open --launch TerminalEmulator"
set_xfconf $K "/commands/custom/<Alt><Super>s"          string "orca"
set_xfconf $K "/commands/custom/<Super>e"               string "thunar"
set_xfconf $K "/commands/custom/<Super>space"           string "xfce4-appfinder"
set_xfconf $K "/commands/custom/<Super>p"               string "xfce4-display-settings --minimal"
set_xfconf $K "/commands/custom/<Shift><Super>s"        string "xfce4-screenshooter -r"
set_xfconf $K "/commands/custom/<Shift><Primary>Escape" string "xfce4-taskmanager"
set_xfconf $K "/commands/custom/<Super>l"               string "xflock4"

for n in 1 2 3; do
    set_xfconf $K "/xfwm4/custom/<Super>$n"        string "workspace_${n}_key"
    set_xfconf $K "/xfwm4/custom/<Shift><Super>$n" string "move_window_${n}_key"
done
