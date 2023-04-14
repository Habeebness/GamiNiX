{pkgs, ...}: {
  disabledModules = ["programs/steam.nix"];
  imports = [
    (builtins.fetchurl {
      url = "https://raw.githubusercontent.com/NixOS/nixpkgs/2d6289417958c618a4cd61f1659465246745ce44/nixos/modules/programs/gamescope.nix";
      sha256 = "sha256:0p2zx14m5ya1p7541bvjfqq3zv257zvxph5y9ryd3hnpzsk1li5y";
    })
    (builtins.fetchurl {
      url = "https://raw.githubusercontent.com/NixOS/nixpkgs/2d6289417958c618a4cd61f1659465246745ce44/nixos/modules/programs/steam.nix";
      sha256 = "sha256:0y3lhwn9frd22xswzf1pdm3h2drsjchqnbil9asj8vkyz7v9r8zv";
    })
  ];

  programs.steam.enable = true;

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
