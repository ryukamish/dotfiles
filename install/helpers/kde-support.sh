#!/usr/bin/env bash

# This script is used to install the KDE support for hyprland.
mkdir -p ~/.config/xdg-desktop-portal
tee ~/.config/xdg-desktop-portal/hyprland-portals.conf <<'EOF'
[preferred]
default=hyprland;gtk
org.freedesktop.impl.portal.FileChooser=kde
EOF

# Fix XDG menu prefix for app associations
sudo ln -s /etc/xdg/menus/plasma-applications.menu /etc/xdg/menus/applications.menu
