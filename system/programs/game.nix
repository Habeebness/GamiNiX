{pkgs, ...}: {
  disabledModules = ["programs/steam.nix"];
  imports = [
    ./self-built/steam.nix
    ./self-built/gamescope.nix
  ];

  programs.steam.enable = true;
  environment.sessionVariables = rec { STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d"; };
  # gamescope module (not yet merged nixos/nixpkgs#187507)
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
  programs.gamemode.enableRenice = true;
  programs.gamescope.enable = true;
  programs.gamescope.capSysNice = true;
  
  # ----------------------------------

  # fps games on laptop need this
  services.xserver.libinput.touchpad.disableWhileTyping = false;

  # 32-bit support needed for steam
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # better for steam proton games
  systemd.extraConfig = "DefaultLimitNOFILE=1048576";

  # improve wine performance
  environment.sessionVariables = {WINEDEBUG = "-all";};

  # steam hardware
  hardware.steam-hardware.enable = true;
}
