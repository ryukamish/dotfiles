#!/usr/bin/env bash

source "$(pwd)/install/helpers/all.sh"

RED="\e[31m" BLUE="\e[34m"
GREEN="\e[32m" RESET="\e[0m"

# Checking for internet connection
if ping -c archlinux.org >/dev/null; then
    printf '%b\n' "${GREEN}Internet connection is available${RESET}"
else
    printf '%b\n' "${RED}Internet connection is not available${RESET}"
fi

# Installing packages
if ! command -v git &>/dev/null; then
    printf '%b\n' "${RED}Git is not installed.${RESET} ${BLUE}Installing Git...${RESET}"
    sudo pacman -S --needed --noconfirm git
    if [ $? -ne 0 ]; then
        printf '%b\n' "${RED}Failed to install Git.${RESET}"
        exit 1
    fi
else
    printf '%b\n' "${GREEN}Git is installed.${RESET}"
fi

# Installing yay
if command -v yay /dev/null; then
    printf '%b\n' "${GREEN}Yay is installed.${RESET}"
else
    printf '%b\n' "${RED}Yay is not installed.${RESET} ${BLUE}Installing Yay...${RESET}"
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    makepkg -si --dir /tmp/yay-bin --noconfirm
    rm -rf /tmp/yay-bin
    if [ $? -ne 0 ]; then
        printf '%b\n' "${RED}Failed to install Yay.${RESET}"
        exit 1
    fi
fi

# Read packages from packages.txt
packages=()
while IFS= read -r line; do
  [[ -n "$line" ]] && packages+=("$line")
done <install.packages

# Function to check if package is installed
is_installed() {
  if yay -Qi "$1" &>/dev/null; then
    return 0
  else
    return 1
  fi
}

# Check and install packages
to_install=()
for package in "${packages[@]}"; do
  # Skip empty lines
  if [ -z "$package" ]; then
    continue
  fi

  if is_installed "$package"; then
    echo "✓ $package is already installed"
  else
    echo "✗ $package is not installed"
    to_install+=("$package")
  fi
done

# Install missing packages using yay
if [ ${#to_install[@]} -gt 0 ]; then
  echo ""
  echo "Installing missing packages: ${to_install[*]}"
  yay -S --needed --noconfirm "${to_install[@]}"
else
  echo ""
  echo "✅ All packages are already installed!"
fi

# Suspend support
read -r -p "Enable suspend to RAM (deep sleep) support? (y/n): " enable_suspend
if [[ "$enable_suspend" != "y" && "$enable_suspend" != "Y" ]]; then
    printf '%b\n' "${BLUE}Skipping suspend to RAM (deep sleep) support setup...${RESET}"
    exit 0
elif [[ "$enable_suspend" == "y" || "$enable_suspend" == "Y" ]]; then
    printf '%b\n' "${BLUE}Enabling suspend to RAM (deep sleep) support...${RESET}"
    if [ ! -d /etc/systemd/sleep.conf.d ]; then
        sudo mkdir -p /etc/systemd/sleep.conf.d/mem-deep.conf
    elif [ -d /etc/systemd/sleep.conf.d ]; then
        sudo tee /etc/systemd/sleep.conf.d/mem-deep.conf <<'EOF'
[Sleep]
MemorySleepMode=deep
EOF
    fi
fi

# Wireguard and systemd-resolvconf setup
# if ! systemctl is-enabled systemd-resolved.service | grep -q disabled; then
#   sudo systemctl enable --now systemd-resolved.service
#   sudo systemctl start --now systemd-resolved.service
# fi

# Setting Cloudflare & Google DNS
# if [ -d /etc/systemd/resolved.conf.d ]; then
#   sudo mkdir -p /etc/systemd/resolved.conf.d
#   # Not using resolved.conf file directly as could cause issues
#   sudo tee /etc/systemd/resolved.conf.d/99-auto-dns.conf <<'EOF'
# [Resolve]
# DNS=1.1.1.1#cloudflare-dns.com 1.0.0.1#cloudflare-dns.com
# FallbackDNS=8.8.8.8 8.8.4.4#Cloudflare Google
# DNSSEC=no
# Cache=yes
# EOF
# fi

# Firewall setup with ufw
if command -v ufw /dev/null; then
    sudo systemctl enable --now ufw.service
    sudo ufw default deny incoming
    sudo ufw default deny outgoing
    # For ProtonVPN
    sudo ufw allow in on proton0
    sudo ufw allow out on proton0
fi

# Stowing config files
stow -t ~/.config config
# User scripts
stow -t ~/.local scripts
stow -t ~/.local/share/applications applications
# Initial backgrounds
stow -t ~/.local/share/backgrounds backgrounds

# Sourcing all files for bash
tee -a ~/.bashrc <<'EOF'
if [ -d "$HOME/.config/bash" ]; then
    for file in "$HOME/.config/bash/"*; do
        . "$file"
    done
fi
EOF

# If using doas, allow wheel group to use sudo
# if [ -f '/etc/doas.conf' ]; then
#   cat <<'EOF'
# permit persist setenv {PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin} :wheel
# EOF
# fi

# Make default XDG directories
# xdg-user-dirs-update
