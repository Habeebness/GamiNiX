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
		defaultLocale = "en_US.utf8";
		extraLocaleSettings.LC_MEASUREMENT = "en_CA.utf8";
		extraLocaleSettings.LC_MONETARY = "en_CA.utf8";
    extraLocaleSettings.LC_PAPER = "en_CA.utf8";
    extraLocaleSettings.LC_TIME = "en_CA.utf8";
    extraLocaleSettings.LC_NUMERIC = "en_CA.utf8";
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

	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true; # Enable service which hands out realtime scheduling priority to user processes on demand, required by pipewire

	networking = {
		networkmanager.enable = true;
		firewall.enable = false;
	};

	security.sudo.extraConfig = "Defaults pwfeedback"; # Show asterisks when typing sudo password


	### A tidy $HOME is a tidy mind
  home-manager.users.${config.main.user.username}.xdg.enable = true;

  environment = {
		
    sessionVariables = {
      # These are the defaults, and xdg.enable does set them, but due to load
      # order, they're not set before environment.variables are set, which could
      # cause race conditions.
			QT_QPA_PLATFORMTHEME= "gnome"; 					# Use gtk theme for qt apps
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_BIN_HOME = "$HOME/.local/bin";
			DEFAULT_BROWSER="${pkgs.google-chrome-beta}/bin/google-chrome-beta";
    };
    variables = {
      # Conform more programs to XDG conventions. The rest are handled by their
      # respective modules.
      __GL_SHADER_DISK_CACHE_PATH = "$XDG_CACHE_HOME/nv";
      ASPELL_CONF = ''
        per-conf $XDG_CONFIG_HOME/aspell/aspell.conf;
        personal $XDG_CONFIG_HOME/aspell/en_US.pws;
        repl $XDG_CONFIG_HOME/aspell/en.prepl;
      '';
      CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
      HISTFILE = "$XDG_DATA_HOME/bash/history";
      INPUTRC = "$XDG_CONFIG_HOME/readline/inputrc";
      LESSHISTFILE = "$XDG_CACHE_HOME/lesshst";

      # Tools I don't use
      # SUBVERSION_HOME = "$XDG_CONFIG_HOME/subversion";
      # BZRPATH         = "$XDG_CONFIG_HOME/bazaar";
      # BZR_PLUGIN_PATH = "$XDG_DATA_HOME/bazaar";
      # BZR_HOME        = "$XDG_CACHE_HOME/bazaar";
      # ICEAUTHORITY    = "$XDG_CACHE_HOME/ICEauthority";
    };
		# Packages to install for all window manager/desktop environments
		systemPackages = with pkgs; [
			bibata-cursors 							# Material cursors
			fragments 									# Bittorrent client following Gnome UI standards
			gnome.adwaita-icon-theme 		# GTK theme
			gnome.gnome-boxes 					# VM manager
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
