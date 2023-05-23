### PACKAGES INSTALLED ON MAIN USER ###
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
lib.mkIf config.main.user.enable {
  users.users.${config.main.user.username}.packages = with pkgs;
    lib.mkIf config.main.user.enable [
      alejandra # The Uncompromising Nix Code Formatter
      bottles # Wine manager
      cemu # Wii U Emulator
      mangohud # Performance monitoring tool for Vulkan and OpenGL games
      vulkan-tools # Tools for developing and debugging Vulkan applications
      spotify # Music streaming service
      duckstation # PlayStation 1 emulator
      godot_4 # Game engine for 2D and 3D games
      heroic # Epic Games Launcher for Linux
      xfce.thunar # File manager
      input-remapper # Tool for remapping input device controls
      papermc # Minecraft server software
      pcsx2 # PlayStation 2 emulator
      ppsspp # PSP emulator
      #prismlauncher # Minecraft launcher
      protontricks # Tool for managing Winetricks for Proton prefixes
      rpcs3 # PlayStation 3 emulator
      ryujinx # Nintendo Switch emulator
      scanmem # Cheat engine for Linux
      stremio # Streaming platform for movies and TV shows
      sunshine # Remote gaming solution for streaming games over the internet
      prusa-slicer # 3D printer slicer software for slicing 3D models into printable layers
      inav-configurator # The iNav flight control system configuration tool
      betaflight-configurator # The Betaflight flight control system configuration tool
    ];

  programs.xfconf.enable = true;
  services.input-remapper.enable = config.main.user.enable;
  services.input-remapper.enableUdevRules = config.main.user.enable;
}
