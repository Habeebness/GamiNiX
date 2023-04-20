{ config, pkgs, lib, ... }:

lib.mkIf config.main.user.enable {
	home-manager.users.${config.main.user.username} = {
		services.kdeconnect.enable = true;
		gtk = {
			# Change GTK themes
			enable = true;
			theme = {
				name = "Adwaita-dark";
			};
			cursorTheme = {
				name = "Bibata-Modern-Classic";
			};
			iconTheme = {
				name = "Tela-black-dark";
			};
		};



		xdg = {
			desktopEntries = {
				discord = {
					name = "Discord";
					exec = "discord --enable-features=UseOzonePlatform --ozone-platform=wayland";
					icon = "discord";
				}; # Force discord to use wayland

				mullvad-gui = {
					name = "Mullvad";
					exec = "mullvad-gui --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland";
					icon = "mullvad-vpn";
				}; # Force mullvad to use wayland and window decorations
			};

			mimeApps = {
				enable = true;

				defaultApplications = {
					"application/x-bittorrent" = [ "de.haeckerfelix.Fragments.desktop" ];
					"text/html" = [ "google-chrome-beta.desktop" ];
          "x-scheme-handler/http" = [ "google-chrome-beta.desktop" ];
          "x-scheme-handler/https" = [ "google-chrome-beta.desktop" ];
          "x-scheme-handler/about" = [ "google-chrome-beta.desktop" ];
          "x-scheme-handler/unknown" = [ "google-chrome-beta.desktop" ];
					"application/x-ms-dos-executable" = [ "wine.desktop" ];
					"application/zip" = [ "org.gnome.FileRoller.desktop" ];
					"image/jpeg" = [ "org.gnome.gThumb.desktop" ];
					"image/avif"= [ "org.gnome.gThumb.desktop" ];
					"image/png" = [ "org.gnome.gThumb.desktop" ];
					"text/plain" = [ "sublime_text.desktop" ];
					"video/mp4" = [ "vlc.desktop" ];
				};
			}; # Default apps
		};

		home.file = {
			"Templates/new" = {
				text = "";
				recursive = true;
			};

			"Templates/new.cfg" = {
				text = "";
				recursive = true;
			};

			"Templates/new.ini" = {
				text = "";
				recursive = true;
			};

			"Templates/new.sh" = {
				text = "";
				recursive = true;
			};

			"Templates/new.txt" = {
				text = "";
				recursive = true;
			};
		}; # New document options for nautilus
	};
}
