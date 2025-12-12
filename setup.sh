#!/usr/bin/env bash

source "${PWD}/install/helpers/all.sh"

readonly RED="\e[31m"
readonly BLUE="\e[34m"
readonly GREEN="\e[32m"
readonly RESET="\e[0m"

msg() {
    case "$1" in
        error)
            printf '%b\n' "${RED}Error:${RESET} $2"
            ;;
        debug)
            printf '%b\n' "${BLUE}Debug:${RESET} $2"
            ;;
        complete)
            printf '%b\n' "${GREEN}Info:${RESET} $2"
            ;;
    esac
}

# Checking for internet connection
if ping -c archlinux.org >/dev/null; then
    msg complete "Internet connection is available"
else
    msg error "Internet connection is not available"
fi

# Installing packages
if ! command -v git &>/dev/null; then
    msg error "Git is not installed."
    msg debug "Installing git..."
    sudo pacman -S --needed --noconfirm git
    if [ $? -ne 0 ]; then
        msg error "Failed to install git."
        exit 1
    fi
else
    msg complete "Git is installed."
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
        sudo tee /etc/systemd/sleep.conf.d/mem-deep.conf <<'EOF'
[Sleep]
MemorySleepMode=deep
EOF
    elif [ -d /etc/systemd/sleep.conf.d ]; then
        sudo tee /etc/systemd/sleep.conf.d/mem-deep.conf <<'EOF'
[Sleep]
MemorySleepMode=deep
EOF
    fi
fi

# Wireguard and systemd-resolvconf setup
if ! systemctl is-enabled systemd-resolved.service | grep -q disabled; then
  sudo systemctl enable --now systemd-resolved.service
  sudo systemctl start --now systemd-resolved.service
fi

# Setting Cloudflare & Google DNS
read -r -p "Set Cloudflare & Google DNS for systemd-resolved? (y/n): " set_dns
if [ "$set_dns" == "y" ]; then
    if [ ! -d /etc/systemd/resolved.conf.d ]; then
        sudo mkdir -p /etc/systemd/resolved.conf.d
    elif [ -d /etc/systemd/resolved.conf.d ]; then
        sudo mkdir -p /etc/systemd/resolved.conf.d
        # Not using resolved.conf file directly as could cause issues
        sudo tee /etc/systemd/resolved.conf.d/99-auto-dns.conf <<'EOF'
[Resolve]
DNS=1.1.1.1,1.0.0.1
FallbackDNS=8.8.8.8,8.8.4.4
DNSSEC=no
Cache=yes
EOF
    fi
elif [ "$set_dns" != "y" ]; then
    msg complete "Skipping DNS setup for systemd-resolved..."
fi

# Firewall setup with ufw
if command -v ufw /dev/null; then
    sudo ufw limit 22/tcp # SSH
    sudo ufw allow 80/tcp # HTTP
    sudo ufw allow 443/tcp # HTTPS
    sudo systemctl enable --now ufw.service
    sudo ufw default deny incoming
    sudo ufw default deny outgoing
    # For ProtonVPN
    sudo ufw allow in on proton0
    sudo ufw allow out on proton0
fi

# Make default XDG directories
xdg-user-dirs-update

# Stowing config files
if command -v stow &>/dev/null; then
    stow -t ~/.config config
    stow -t ~/.local scripts
    stow -t ~/.local/share/applications applications
    ln -s config/zsh/zshrc ~/.zshrc         # FIX: Add option to check whether to use bash or zsh
else
    msg error "Stow is not installed."
fi

# Systemd units
if [ -d ~/.config/systemd/user ]; then
    systemctl --user daemon-reload
    # Battery monitor service
    systemctl --user enable --now battery-monitor.service
    systemctl --user start --now battery-monitor.service
fi

# Sourcing all files for bash
tee -a ~/.bashrc <<'EOF'
if [ -d "$HOME/.config/bash" ]; then
    for file in "$HOME/.config/bash/"*; do
        . "$file"
    done
fi
EOF

