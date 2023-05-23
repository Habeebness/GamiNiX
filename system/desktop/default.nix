### DESKTOP POWERED BY GNOME ###
{
  pkgs,
  config,
  lib,
  sops-nix,
  ...
}: {
  imports = [
    ./home-main.nix
    ./theming.nix
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
      desktopManager.plasma5.enable = true;
      displayManager = {
        sddm = {
          autoNumlock = true;
          enable = true;
          settings = {
            General = {Font = "Fira Sans";};
            #Autologin = { User = "iggut"; Session = "plasma"; };
          };
          theme = "Sweet";
        };
      };
      enable = true;
      excludePackages = [pkgs.xterm];

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

  services = {
    gnome.gnome-keyring.enable = true;
    flatpak.enable = true;
    printing.enable = true;
    printing.drivers = [
      #pkgs.cnijfilter2
      #pkgs.cnijfilter_4_00
      pkgs.gutenprint
      pkgs.gutenprintBin
    ];
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true; # Enable service which hands out realtime scheduling priority to user processes on demand, required by pipewire

  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };

  security.sudo.extraConfig = "Defaults pwfeedback"; # Show asterisks when typing sudo password

  programs.dconf.enable = true;
  programs.partition-manager.enable = true;

  # Power profiles daemon
  services.power-profiles-daemon.enable = true;

  # LAN discovery
  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  # Remove a few applications that aren't needed
  environment.plasma5.excludePackages = with pkgs;
  with libsForQt5; [
    oxygen
    plasma-browser-integration
  ];
  environment = {
    sessionVariables = {
      # These are the defaults, and xdg.enable does set them, but due to load
      # order, they're not set before environment.variables are set, which could
      # cause race conditions.
      QT_QPA_PLATFORMTHEME = "kvantum";
      MOZ_USE_XINPUT2 = "1";
      QT_STYLE_OVERRIDE = "kvantum";
      QT_QPA_PLATFORM = "wayland;xcb";
      NIXOS_OZONE_WL = "1";
      XDG_DATA_HOME = "$HOME/.local/share";
    };

    # Packages to install for all window manager/desktop environments
    systemPackages = with pkgs; [
      applet-window-appmenu
      applet-window-title
      beautyline-icons
      dr460nized-kde-theme
      firedragon
      jamesdsp
      libinput-gestures
      libsForQt5.applet-window-buttons
      libsForQt5.bismuth
      libsForQt5.kdegraphics-thumbnailers
      libsForQt5.kimageformats
      libsForQt5.qtstyleplugin-kvantum
      resvg
      sshfs
      sweet
      sweet-nova
      bibata-cursors # Material cursors
      fragments # Bittorrent client following Gnome UI standards
      gnome.adwaita-icon-theme # GTK theme
      gnome.dconf-editor # Edit gnome's dconf
      gnome.gnome-boxes # VM manager
      gnome.gucharmap # Gnome char map
      gnome.gnome-keyring # Gnome keyring
      gthumb # Image viewer
      gtk-engine-murrine # Theme engine needed by Orchis theme
      orchis-theme # GTK theme
      pitivi # Video editor
      qgnomeplatform # Use GTK theme for QT apps
      sops
      tela-icon-theme # Icon theme
    ];

    # Move ~/.Xauthority out of $HOME (setting XAUTHORITY early isn't enough)
    extraInit = ''
      export XAUTHORITY=/tmp/Xauthority
      [ -e ~/.Xauthority ] && mv -f ~/.Xauthority "$XAUTHORITY"
    '';
  };

  # Define the default fonts Fira Sans & Jetbrains Mono Nerd Fonts
  fonts = {
    enableDefaultFonts = false;
    fonts = with pkgs; [
      fira
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
        ];
      })
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
    fontconfig = {
      cache32Bit = true;
      defaultFonts = {
        emoji = ["Noto Color Emoji"];
        monospace = ["JetBrains Mono Nerd Font" "Noto Fonts Emoji"];
        sansSerif = ["Fira" "Noto Fonts Emoji"];
        serif = ["Fira" "Noto Fonts Emoji"];
      };
      # This fixes emoji stuff
      enable = true;
    };
    fontDir = {
      enable = true;
      decompressFonts = true;
    };
  };
}
