### PACKAGES INSTALLED ON MAIN USER ###
{ config, pkgs, lib, inputs, ... }:

lib.mkIf config.main.user.enable {
	programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        libgdiplus
        zulu
				gtk3
        zlib
        dbus
        freetype
        glib
        atk
        cairo
				mono
        gdk-pixbuf
        pango
        fontconfig
				gnutls # needed for Halo MCC
				stdenv.cc.cc.lib
				gamescope # Wayland microcompositor
				SDL2
				icu63
				libtensorflow
				fontconfig
      ];
    };
  };

	users.users.${config.main.user.username}.packages = with pkgs; lib.mkIf config.main.user.enable [
		bottles # Wine manager
		spotify # Viva la musica
		duckstation # PS1 Emulator
		godot_4 # Game engine
		heroic # Epic Games Launcher for Linux
		input-remapper # Remap input device controls
		papermc # Minecraft server
		pcsx2 # PS2 Emulator
		ppsspp # PSP Emulator
		prismlauncher # Minecraft launcher
		protontricks # Winetricks for proton prefixes
		rpcs3 # PS3 Emulator
		ryujinx # Switch Emulator
		scanmem # Cheat engine for linux
		#steam # Gaming platform
		steamtinkerlaunch # General tweaks for games
		stremio # Straming platform
		sunshine # Remote gaming
		prusa-slicer # 3D printer slicer software
	];

	services.input-remapper.enable = config.main.user.enable;
	services.input-remapper.enableUdevRules = config.main.user.enable;
}
