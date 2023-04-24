### DESKTOP POWERED BY GNOME ###
{ pkgs, config, lib, ... }:

{
	imports = [
		./home-main.nix
	]; # Setup home manager

	# Set your time zone
	time.timeZone = "America/Toronto";

	# Set your locale settings
	i18n = {
		defaultLocale = "en_US.UTF-8";
		extraLocaleSettings = {
			LANGUAGE = "en_US.UTF-8";
			LC_ALL = "en_US.UTF-8";
    };
		supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_CA.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
	};

	services = {
		xserver = {
			enable = true; # Enable the X11 windowing system

			displayManager = {
				gdm = {
					enable = true;
					autoSuspend = config.desktop-environment.gdm.auto-suspend.enable;
				};

				autoLogin = lib.mkIf config.boot.autologin.enable {
					enable = true;
  					user = if (config.main.user.enable && config.boot.autologin.main.user.enable) then config.main.user.username
						else "";
				};
			};

			layout = "us";
		};

		# Enable sound with pipewire
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
		};
	};

	# Workaround for GDM autologin
	systemd.services = {
		"getty@tty1".enable = false;
		"autovt@tty1".enable = false;
	};

	services.gnome.gnome-keyring.enable = true;

	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true; # Enable service which hands out realtime scheduling priority to user processes on demand, required by pipewire

	networking = {
		networkmanager.enable = true;
		firewall.enable = false;
	};

	security.sudo.extraConfig = "Defaults pwfeedback"; # Show asterisks when typing sudo password

  programs.dconf.enable = true;
  environment = {
		
    sessionVariables = {
      # These are the defaults, and xdg.enable does set them, but due to load
      # order, they're not set before environment.variables are set, which could
      # cause race conditions.
			QT_QPA_PLATFORMTHEME= "gnome"; 					# Use gtk2 theme for qt apps
      NIXOS_OZONE_WL = "1";
    };

		# Packages to install for all window manager/desktop environments
		systemPackages = with pkgs; [
			bibata-cursors 							# Material cursors
			fragments 									# Bittorrent client following Gnome UI standards
			gnome.adwaita-icon-theme 		# GTK theme
			gnome.gnome-boxes 					# VM manager
			gnome.gucharmap							# Gnome char map 
			gnome.gnome-keyring					# Gnome keyring 
			gthumb 											# Image viewer
			pitivi 											# Video editor
			qgnomeplatform 							# Use GTK theme for QT apps
			tela-icon-theme 						# Icon theme
		];

    # Move ~/.Xauthority out of $HOME (setting XAUTHORITY early isn't enough)
    extraInit = ''
      export XAUTHORITY=/tmp/Xauthority
      [ -e ~/.Xauthority ] && mv -f ~/.Xauthority "$XAUTHORITY"
    '';
  };

	fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "NerdFontsSymbolsOnly" ]; })
		meslo-lgs-nf 
		cantarell-fonts 
		jetbrains-mono 
		font-awesome 
  ];
}
