#!/usr/bin/env bash

core_packages=(
	# Core
	base base-devel linux linux-headers linux-firmware sof-firmware networkmanager git

	# Desktop
	hyprland hyprsunset hyprlock hyprshot hyprpicker hypridle uwsm waybar ly 
	bluez bluez-utils brightnessctl kitty satty slurp grim exfatprogs
	pipewire pipewire-pulse pipewire-jack wiremix wireplumber pipewire-alsa
	noto-fonts noto-fonts-cjk noto-fonts-emoji
	mako yazi rofi rofi-emoji stow swww terminus-font wl-clipboard wl-clip-persist
	xdg-desktop-portal-gtk xdg-user-dirs xdg-utils udisks2-btrfs ttf-jetbrains-mono-nerd
	trash-cli qt6-wayland qt5-wayland

	# Screenshot & Recording
	ffmpeg v4l-utils

	# Security
	ufw wireguard-tools

	# Multimedia
	mpv gst-plugin-pipewire gst-plugins-bad gst-plugins-good gst-plugins-ugly

	# Intel specific drivers
	intel-media-driver intel-ucode vulkan-intel vulkan-nouveau vulkan-radeon libva-intel-driver

	# Editor
	neovim lazygit

	# Utilities
	rsync shellcheck ripgrep npm man-db libnotify libappindicator 
	jq gnome-themes-extra fastfetch fd fzf eza cliphist bat btop age 7zip gum
	)

aur_packages=(
	gpu-screen-recorder
	bluetui
	wifitui-bin
	zen-browser-bin
	ticktick
	telegram-desktop
	localsend-bin
	kew
	)

msg(){
	RED='\033[0;31m'
	GREEN='\033[0;32m'
	BLUE='\033[0;34m'
	RESET='\033[0m'
	case "$1" in
	error)
		printf '%b\n' "${RED}Error:${RESET} $2"
		exit 1
		;;
	debug)
		printf '%b\n' "${BLUE}Debug:${RESET} $2"
		;;
	success)
		printf '%b\n' "${GREEN}Info:${RESET} $2"
		;;
	esac
}

# Checking for internet connection
msg debug "Checking for internet connection..."
if ping -c 3 archlinux.org >/dev/null; then
	msg success "Internet connection is available"
else
	printf '%b' "\e[31m[INFO]\e[0m Internet connection is not available"
	msg error "Internet connection is not available"
	exit 1
fi

# Check for git
check_deps(){
	if command -v git &>/dev/null; then
		msg success "Git is installed."
	else
		msg debug "Git is not installed."
		msg debug "Installing git..."
		sudo pacman -S --needed --noconfirm git
		if [ $? -ne 0 ]; then
			msg error "Failed to install git."
			exit 1
		fi
	fi

	# Check for yay
	if command -v yay &>/dev/null; then
		msg success "Yay is installed."
	else
		msg debug "Installing yay..."
		git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
		makepkg -si --dir /tmp/yay-bin --noconfirm
		rm -rf /tmp/yay-bin
		if [ $? -ne 0 ]; then
			msg error "Failed to install yay..."
			exit 1
		fi
	fi
}

# Install packages
install_core_packages(){
	for package in "${core_packages[@]}"; do
		if pacman -Qi "$package" &>/dev/null; then
			msg debug "Skipping $package"
		else
			msg debug "Installing $package"
			sudo pacman -S "$package" --noconfirm
		fi
	done
}

install_aur_packages(){
	for package in "${aur_packages[@]}"; do
		if pacman -Qi "$package" &>/dev/null; then
			msg debug "$package is already installed"
		else
			msg debug "Installing $package"
			yay -S "$package" --noconfirm --needed
		fi
	done
}

msg debug "Checking for dependencies..."
check_deps
msg success "Dependencies are installed."
msg debug "Installing packages..."
install_core_packages
msg success "Core packages are installed."
msg debug "Installing AUR packages..."
install_aur_packages
msg success "AUR packages are installed."
true
