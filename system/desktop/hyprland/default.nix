{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./home-main.nix
  ]; # Setup home manager for hyprland

  programs = lib.mkIf config.desktop-environment.hyprland.enable {
    nm-applet.enable = true; # Network manager tray icon
    kdeconnect.enable = true; # Connect phone to PC
  };

  environment = lib.mkIf config.desktop-environment.hyprland.enable {
    systemPackages = with pkgs; [
      # Status bar
      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
        postPatch = ''
          sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
        '';
      }))
      baobab # Disk usage analyser
      blueberry # Bluetooth manager
      clipman # Clipboard manager for wayland
      dotnet-sdk_7 # SDK for .net
      fd # Find alternative
      gdtoolkit # Tools for gdscript
      gnome.file-roller # Archive file manager
      gnome.gnome-calculator # Calculator
      gnome.gnome-disk-utility # Disks manager
      gnome.nautilus # File manager
      grim # Screenshot tool
      jc # JSON parser
      playerctl # mpris controller
      brightnessctl # Adjust screen brightness
      pamixer # PulseAudio mixer
      networkmanagerapplet # Network manager tray icon
      nixfmt # A nix formatter
      pavucontrol # Sound manager
      nwg-drawer # Sexy app launcher
      nwg-menu # Sexy app menu
      polkit_gnome # Polkit manager
      ripgrep # Silver searcher grep
      rofi-wayland # App launcher
      slurp # Monitor selector
      swappy # Edit screenshots
      swaynotificationcenter # Notification daemon
      unzip # An extraction utility
      wdisplays # Displays manager
      wl-clipboard # Clipboard daemon
      wlogout # Logout screen
      swww # Wallpaper
      eww-wayland # Widgets and bars
      mpvpaper # Play videos with mpv as your wallpaper
    ];

    # Configure system services
    etc = {
      "wlogout-icons".source = "${pkgs.wlogout}/share/wlogout/icons";
      "polkit-gnome".source = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      "kdeconnectd".source = "${pkgs.libsForQt5.kdeconnect-kde}/libexec/kdeconnectd";
    };
  };

  services = lib.mkIf config.desktop-environment.hyprland.enable {
    dbus.enable = true;
    gvfs.enable = true; # Needed for nautilus
  };

  security.polkit.enable = lib.mkIf config.desktop-environment.hyprland.enable true; # Enable polkit security

  disabledModules = ["programs/hyprland.nix"]; # Needed for hyprland flake
}
