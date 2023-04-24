### PACKAGES INSTALLED ON ALL USERS ###
{ pkgs, config, ... }:

{
	boot.kernelPackages = pkgs.linuxPackages_xanmod_latest; # Latest Xanmod Kernel

	environment.systemPackages = with pkgs; [
		(callPackage ./self-built/apx.nix {})                                                  											# Package manager using distrobox
		(callPackage ./self-built/webcord {})                                                  											# An open source discord client
		(firefox.override { extraNativeMessagingHosts = [ (callPackage ./self-built/pipewire-screenaudio {}) ]; }) 	# Browser
		(pkgs.wrapOBS {plugins = with pkgs.obs-studio-plugins; [obs-pipewire-audio-capture];}) 											# Pipewire audio plugin for OBS Studio
    (callPackage ./self-built/sfwbar {})        # Status bar for Wayland
    google-chrome-beta                          # Hate it and love it Browser
    nwg-panel								# Sexy status panel
		glxinfo									# GL gpu info
		android-tools           # Tools for debugging android devices
		appimage-run            # Appimage runner
		samba4Full 							# Samba server to share files/printers with windows
		aria                    # Terminal downloader with multiple connections support
		bat                     # Better cat command
		btop                    # System monitor
		discord                 # Chat client
		cinnamon.warpinator     # Local file sync
		curtail 								# Image compressor
		direnv                  # Unclutter your .profile
		efibootmgr              # Edit EFI entries
		firefox                 # Browser
		gimp                    # Image editor
		git                     # Distributed version control system
		gping                   # ping with a graph
		helvum                  # Pipewire patchbay
		killall                 # Tool to kill all programs matching process name
		kitty                   # Terminal
		lsd                     # Better ls command
		mpv                     # Video player
		vlc                     # Video player
		neofetch                # pc info
		libnotify               # Send desktop notifications
		bc                      # Arbitrary precision calculator language
		pciutils                # I need me some lspci
		mullvad-vpn             # VPN Client
		neovim 									# Terminal text editor
		ntfs3g                  # Support NTFS drives
		obs-studio              # Recording/Livestream
		onlyoffice-bin          # Microsoft Office alternative for Linux
		p7zip                   # 7zip
		python3                 # Python
		ranger                  # Terminal file manager
		rnix-lsp                # Nix language server
		rnnoise-plugin          # A real-time noise suppression plugin
		signal-desktop          # Encrypted messaging platform
		sublime4                # Text editor
		tree                    # Display folder content at a tree format
		unrar                   # Support opening rar files
		vscodium                # All purpose IDE
		wget                    # Terminal downloader
		lutris                  # Windows gaming
		pulseaudio              # Sound server for Linux-based systems
		wine                    # Compatibility layer capable of running Windows applications
		winetricks              # Wine prefix settings manager
		woeusb                  # Windows ISO Burner
		xorg.xhost              # Use x.org server with distrobox
		zerotierone             # Virtual lan network
	];
  
	users.defaultUserShell = pkgs.zsh; # Use ZSH shell for all users
  
	programs = {
		
		zsh = {
			enable = true;
			# Enable oh my zsh and it's plugins
			ohMyZsh = {
				enable = true;
				plugins = [ "git" "npm" "nvm" "sudo" "systemd" ];
			};
			autosuggestions.enable = true;

			syntaxHighlighting.enable = true;

			# Aliases
			shellAliases = {
				apx="apx --aur"; # Use arch as the base apx container
				aria2c="aria2c -j 16 -s 16"; # Download with aria using best settings
				btrfs-compress="sudo btrfs filesystem defrag -czstd -r -v"; # Compress given path with zstd
				cat="bat"; # Better cat command
				chmod="sudo chmod"; # It's a command that I always execute with sudo
				clear-keys="sudo rm -rf ~/ local/share/keyrings/* ~/ local/share/kwalletd/*"; # Clear system keys
				cp="rsync -rP"; # Copy command with details
				desktop-files-list="ls -l /run/current-system/sw/share/applications"; # Show desktop files location
				list-packages="nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq"; # List installed nix packages
				ls="lsd"; # Better ls command
				mva="rsync -rP --remove-source-files"; # Move command with details
				ping="gping"; # ping with a graph
				nix-gc="nix-store --gc"; # Garbace collect for the nix store
				#reboot-windows="sudo efibootmgr --bootnext ${config.boot.windows-entry} && reboot"; # Reboot to windows
				rebuild="(cd $(head -1 /etc/nixos/.configuration-location) 2> /dev/null || (echo 'Configuration path is invalid. Run rebuild.sh manually to update the path!' && false) && bash rebuild.sh)"; # Rebuild the system configuration
				restart-pipewire="systemctl --user restart pipewire"; # Restart pipewire
				server="ssh server@192.168.1.2"; # Connect to local server
				ssh="TERM=xterm-256color ssh"; # SSH with colors
				steam-link="killall steam 2> /dev/null ; while ps axg | grep -vw grep | grep -w steam > /dev/null; do sleep 1; done && (nohup steam -pipewire > /dev/null &) 2> /dev/null"; # Kill existing steam process and relaunch steam with the pipewire flag
				updateall="(cd $(head -1 /etc/nixos/.configuration-location) 2> /dev/null || (echo 'Configuration path is invalid. Run rebuild.sh manually to update the path!' && false) && sudo nix flake update && bash rebuild.sh) ; (apx --aur upgrade) ; (bash ~/.config/zsh/proton-ge-updater.sh) ; (bash ~/.config/zsh/steam-library-patcher.sh)"; # Update everything
				update="(apx --aur upgrade) ; (bash ~/.config/zsh/proton-ge-updater.sh) ; (bash ~/.config/zsh/steam-library-patcher.sh)"; 
				vpn-btop="ssh -t server@192.168.1.2 'bpytop'"; # Show VPN bpytop
				vpn-off="ssh -f server@192.168.1.2 'mullvad disconnect && sleep 1 && mullvad status'"; # Disconnect from VPN
				vpn-on="ssh -f server@192.168.1.2 'mullvad connect && sleep 1 && mullvad status'"; # Connect to VPN
				vpn="ssh -f server@192.168.1.2 'mullvad status'"; # Show VPN status
			};

			interactiveShellInit = "source ~/.config/zsh/zsh-theme.zsh\nunsetopt PROMPT_SP"; # Commands to run on zsh shell initialization
		};


	};
  
	services = {
		openssh.enable = true;
		mullvad-vpn.enable = true;
	};

	# Symlink files and folders to /etc
	environment.etc."rnnoise-plugin/librnnoise_ladspa.so".source = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
	environment.etc."proton-ge-nix".source = "${(pkgs.callPackage self-built/proton-ge.nix {})}/";
	environment.etc."apx/config.json".source = "${(pkgs.callPackage self-built/apx.nix {})}/etc/apx/config.json";

}
