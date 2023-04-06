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
		libgdiplus            # Mono library for GDI+ API
        zulu                  # OpenJDK implementation
        gtk3                  # Toolkit for creating graphical user interfaces
        zlib                  # Compression/decompression library
        dbus                  # Message bus system
        freetype              # Font rendering engine
        glib                  # Low-level core library
        atk                   # Accessibility toolkit
        cairo                 # 2D graphics library
        mono                  # Open-source implementation of the .NET framework
        gdk-pixbuf            # Image loading and manipulation library for GTK
        pango                 # Library for layout and rendering of text
        fontconfig            # Library for configuring and customizing font access
        gnutls                # Transport Layer Security library needed for Halo MCC
        stdenv.cc.cc.lib      # C++ library used by the Nix package manager
        SDL2                  # Cross-platform development library for games and multimedia applications
        icu63                 # Library for internationalization support
        libtensorflow         # Library for machine learning and artificial intelligence
      ];
    };
  };

	users.users.${config.main.user.username}.packages = with pkgs; lib.mkIf config.main.user.enable [
	bottles             # Wine manager
    spotify             # Viva la musica
    duckstation         # PS1 Emulator
    godot_4             # Game engine
    heroic              # Epic Games Launcher for Linux
    input-remapper      # Remap input device controls
    papermc             # Minecraft server
    pcsx2               # PS2 Emulator
    ppsspp              # PSP Emulator
    prismlauncher       # Minecraft launcher
    protontricks        # Winetricks for proton prefixes
    rpcs3               # PS3 Emulator
    ryujinx             # Switch Emulator
    scanmem             # Cheat engine for Linux
    steamtinkerlaunch   # General tweaks for games
    stremio             # Streaming platform
    sunshine            # Remote gaming
    prusa-slicer        # 3D printer slicer software

	];

	services.input-remapper.enable = config.main.user.enable;
	services.input-remapper.enableUdevRules = config.main.user.enable;
}
