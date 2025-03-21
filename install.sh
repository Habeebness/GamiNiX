#!/bin/bash

# cd into script's folder
cd "$(cd "$(dirname "$0")" && pwd)" || exit
pwd > .configuration-location

RED='\033[0;31m'
NC='\033[0m'
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

username=$(whoami)
export username

echo "Hello $username!"

read -r -p "Have you customized the setup to your needs? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	# Add configuration files to the appropriate path
	sudo cp -r bootloader /etc/nixos
	sudo cp -r hardware /etc/nixos
	sudo cp -r system /etc/nixos
	sudo cp .configuration-location /etc/nixos
	sudo cp .nix /etc/nixos
	sudo cp configuration.nix /etc/nixos
	sudo cp flake.lock /etc/nixos
	sudo cp flake.nix /etc/nixos

	USERS=$(cut -d: -f1,3 /etc/passwd | grep -E ':[0-9]{4}$' | cut -d: -f1) # Get all users

	if [ -z "$USERS" ]
	then
		echo "No users available to remove firefox profiles ini..."
	else
		while IFS= read -r user ; do
			# Remove potentially generated firefox profiles ini before building the nix configuration
			echo "Removing firefox profiles ini for $user..."
			#sudo rm -rf /home/$user/.mozilla/firefox/profiles.ini 2> /dev/null
            #sudo rm -rf /home/$user/.config/mimeapps.list 2> /dev/null
            #sudo rm -rf /home/$user/.config/hypr/hyprland.conf 2> /dev/null
            #sudo rm -rf /home/$user/.config/hypr/scripts/wallpaper.sh 2> /dev/null
            #sudo rm -rf /home/$user/.config/sfwbar/sfwbar.config 2> /dev/null
		done <<< "$USERS"
	fi

	# Build the configuration
	sudo nixos-rebuild switch

	if [ -f "$HOME/.nix-successful-build" ]; then
		echo "Nix generation was successful!"
		bash system/scripts/reboot.sh
	fi

else
	printf "You really should:
	- Edit .nix, configuration.nix and comment out anything you do not want to setup.
	- Edit mounts.nix or disable it.$RED$BOLD An invalid mounts.nix configuration can break your system!$NC$NORMAL\n"
fi
