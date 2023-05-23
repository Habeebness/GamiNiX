{
  config,
  lib,
  ...
}:
lib.mkIf config.main.user.enable {
  home-manager.users.${config.main.user.username} = lib.mkIf config.desktop-environment.hyprland.enable {
    home.file = {
      ".config/hypr/hyprland.conf" = {
        source = ../../configs/hyprland.conf;
        recursive = true;
        force = true;
      }; # Add hyprland config
      ".config/hypr/scripts/volume" = {
        source = ../../scripts/volume;
        recursive = true;
        force = true;
      }; # Add volume control script for bars
      ".config/hypr/scripts/change-bg.sh" = {
        source = ../../scripts/change-bg.sh;
        recursive = true;
        force = true;
      }; # Add wallpaper change script --mpvpaper
      ".config/waybar/config" = {
        source = ../../configs/waybar/config;
        recursive = true;
        force = true;
      }; # Add waybar config files
      ".config/waybar/style.css" = {
        source = ../../configs/waybar/style.css;
        recursive = true;
        force = true;
      }; # Add waybar style files
      ".config/rofi/config.rasi" = {
        source = ../../configs/rofi/config.rasi;
        recursive = true;
        force = true;
      }; # Add rofi config files
      ".config/rofi/theme.rasi" = {
        source = ../../configs/rofi/theme.rasi;
        recursive = true;
        force = true;
      }; # Add rofi theme
      ".config/nwg-drawer/drawer.css" = {
        source = ../../configs/nwg-drawer/drawer.css;
        recursive = true;
        force = true;
      }; # Add nwg-drawer config files
      ".config/nwg-drawer/desktop-directories" = {
        source = ../../configs/nwg-drawer/desktop-directories;
        recursive = true;
        force = true;
      }; # Add nwg-drawer config files
      ".config/wlogout" = {
        source = ../../configs/wlogout;
        recursive = true;
        force = true;
      }; # Add wlogout config files
      ".config/sfwbar/" = {
        source = ../../configs/sfwbar;
        recursive = true;
        force = true;
      }; # Add sfwbar config
      ".config/hypr/bg/blackhole.webm" = {
        source = ../../configs/bg/blackhole.webm;
        recursive = true;
        force = true;
      }; # Add video wallpapers
      ".config/hypr/bg/dna.mp4" = {
        source = ../../configs/bg/dna.mp4;
        recursive = true;
        force = true;
      }; # Add video wallpapers
      ".config/hypr/bg/dna-vf-blu.webm" = {
        source = ../../configs/bg/dna-vf-blu.webm;
        recursive = true;
        force = true;
      }; # Add video wallpapers
      ".config/hypr/bg/record.mp4" = {
        source = ../../configs/bg/record.mp4;
        recursive = true;
        force = true;
      }; # Add video wallpapers
      ".bashrc" = {
        text = '''';
        recursive = true;
        force = true;
      }; # Avoid file not found errors for bash
    };
  };
}
