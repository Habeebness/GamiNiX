{ config, lib, ... }:

lib.mkIf config.main.user.enable {
	home-manager.users.${config.main.user.username} = lib.mkIf config.desktop-environment.hyprland.enable {
		home.file = {
			# Add hyprland config
			".config/hypr/hyprland.conf" = {
				source = ../../configs/hyprland.conf;
				recursive = true;
				force = true;
			};

			# Add wallpaper change script
			".config/hypr/scripts/wallpaper.sh" = {
				source = ../../scripts/wallpaper.sh;
				recursive = true;
				force = true;
			};

			# Add waybar config files
			".config/waybar/config" = {
				source = ../../configs/waybar/config;
				recursive = true;
				force = true;
			};

			".config/waybar/style.css" = {
				source = ../../configs/waybar/style.css;
				recursive = true;
				force = true;
			};

			# Add rofi config files
			".config/rofi/config.rasi" = {
				source = ../../configs/rofi/config.rasi;
				recursive = true;
				force = true;
			};

			".config/rofi/theme.rasi" = {
				source = ../../configs/rofi/theme.rasi;
				recursive = true;
				force = true;
			};

			# Add dunst config file
			".config/dunst/dunstrc" = {
				source = ../../configs/dunstrc;
				recursive = true;
				force = true;
			};

			# Add wlogout config files
			".config/wlogout/layout" = {
				source = ../../configs/wlogout/layout;
				recursive = true;
				force = true;
			};

			".config/wlogout/style.css" = {
				source = ../../configs/wlogout/style.css;
				recursive = true;
				force = true;
			};

			# Add sfwbar config
			".config/sfwbar/" = {
				source = ../../configs/sfwbar;
				recursive = true;
				force = true;
			};

			# Avoid file not found errors for bash
			".bashrc" = {
				text = '''';
				recursive = true;
				force = true;
			};
		};
	};
}
