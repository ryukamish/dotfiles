#!/usr/bin/env bash

readonly RED="\e[31m"
readonly BLUE="\e[34m"
readonly GREEN="\e[32m"
readonly RESET="\e[0m"

message() {
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

# Installing packages
source "${PWD}/install/packages.sh"

# NOTE: Running command which don't require user intervention

# Firewall setup with ufw
if command -v ufw /dev/null; then
	sudo systemctl enable --now ufw.service
	sudo ufw default deny incoming
	sudo ufw default allow outgoing
	sudo ufw limit 22/tcp  # SSH
	sudo ufw allow 80/tcp  # HTTP
	sudo ufw allow 443/tcp # HTTPS
	# For ProtonVPN
	sudo ufw allow in on proton0
	sudo ufw allow out on proton0
fi

# Make default XDG directories
command -v xdg-user-dirs-update && xdg-user-dirs-update

# Stowing config files
if command -v stow >/dev/null; then
	# Dry run before actually stowing
	stow -n -v -t ~/.config config
	stow -n -v -t ~/.local scripts
	stow -n -v -t ~/.local/share/applications applications
	# Prompt user for confirmation
	read -r -p "Stow the config files? (y/n): " enable_stow
	if [[ "$enable_stow" != "y" && "$enable_stow" != "Y" ]]; then
		message debug "Skipping stowing config files..."
	else
		message success "Stowing config files..."
		# Actual stowing
		stow -t ~/.config config
		stow -t ~/.local scripts
		stow -t ~/.local/share/applications applications
	fi
else
	message error "Stow is not installed."
fi

# Systemd units
if ! systemctl --user is-enabled battery-monitor.service | grep -q disabled; then
	message debug "Installing battery monitor systemd service..."
	systemctl --user daemon-reload
	# Battery monitor service
	systemctl --user enable --now battery-monitor.service
	systemctl --user start --now battery-monitor.service
fi

# Wireguard and systemd-resolvconf setup
if ! systemctl is-enabled systemd-resolved.service | grep -q disabled; then
	sudo systemctl enable --now systemd-resolved.service
	sudo systemctl start --now systemd-resolved.service
fi

# NOTE: User intervention required for these commands

# Suspend support
read -r -p "Enable suspend to RAM (deep sleep) support? (y/n): " enable_suspend
if [[ "$enable_suspend" != "y" && "$enable_suspend" != "Y" ]]; then
	message debug "Skipping suspend to RAM (deep sleep) support setup..."
elif [[ "$enable_suspend" == "y" || "$enable_suspend" == "Y" ]]; then
	printf '%b\n' "${BLUE}Enabling suspend to RAM (deep sleep) support...${RESET}"
	[ -d /etc/systemd/sleep.conf.d ] || sudo mkdir -p /etc/systemd/sleep.conf.d
	sudo tee /etc/systemd/sleep.conf.d/mem-deep.conf <<'EOF'
[Sleep]
MemorySleepMode=deep
EOF
fi

# Setting Cloudflare & Google DNS
read -r -p "Set Cloudflare & Google DNS for systemd-resolved? (y/n): " set_dns
if [ "$set_dns" == "y" ] || [ "$set_dns" == "Y" ]; then
	[ -d /etc/systemd/resolved.conf.d ] || sudo mkdir -p /etc/systemd/resolved.conf.d
	# Not using resolved.conf file directly as could cause issues
	sudo tee /etc/systemd/resolved.conf.d/99-auto-dns.conf <<'EOF'
[Resolve]
DNS=1.1.1.1,1.0.0.1
FallbackDNS=8.8.8.8,8.8.4.4
DNSSEC=no
Cache=yes
EOF
else
	message success "Skipping DNS setup for systemd-resolved..."
fi

# Option for choosing shell
SHELL_LIST=(
	"Bash"
	"Zsh"
)
select shell in "${SHELL_LIST[@]}"; do
	case "${shell}" in
	"Bash")
		tee -a ~/.bashrc <<'EOF'
if [ -d "$HOME/.config/bash" ]; then
for file in "$HOME/.config/bash/"*; do
  . "$file"
done
fi
EOF
		break
		;;
	"Zsh")
		ln -s cofig/zsh/zshrc ~/.config/zsh/.zshrc
		ln -s config/zsh/zshrc ~/.zshrc
		break
		;;
	esac
done

# Dark theme for all GUI applications
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Sourcing it at last so as to not have errors
source "${PWD}/install/helpers/all.sh"
