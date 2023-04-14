{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.steam;
  gamescopeCfg = config.programs.gamescope;

  steam = pkgs.steam.override ({
    extraLibraries = pkgs: with config.hardware.opengl;
      if pkgs.hostPlatform.is64bit
      then [ package ] ++ extraPackages
      else [ package32 ] ++ extraPackages32;
  } // optionalAttrs
    (cfg.gamescopeSession.enable && gamescopeCfg.capSysNice)
    {
      buildFHSUserEnv = pkgs.buildFHSUserEnvBubblewrap.override {
        # use the setuid wrapped bubblewrap
        bubblewrap = "/run/wrappers";
      };
    }
  );

  gamescopeSessionFile = (pkgs.writeTextDir "share/wayland-sessions/steam.desktop" ''
    [Desktop Entry]
    Name=Steam
    Comment=A digital distribution platform
    Exec=${pkgs.writeShellScript "steam-gamescope" ''
      ${let
        exports = builtins.attrValues (builtins.mapAttrs (n: v: "export ${n}=${v}") cfg.gamescopeSession.env);
      in
        builtins.concatStringsSep "\n" exports}
        gamescope --steam ${toString cfg.gamescopeSession.args} -- steam -tenfoot -pipewire-dmabuf
    ''}
    Type=Application
  '').overrideAttrs (_: { passthru.providedSessions = [ "steam" ]; });
in
{
  options.programs.steam = {
    enable = mkEnableOption (mdDoc "steam");

    package = mkOption {
      type        = types.package;
      default     = steam;
      defaultText = literalExpression ''
        pkgs.steam.override {
          extraLibraries = pkgs: with config.hardware.opengl;
            if pkgs.hostPlatform.is64bit
            then [ package ] ++ extraPackages
            else [ package32 ] ++ extraPackages32;
        }
      '';
      description = lib.mdDoc ''
        steam package to use.
      '';
    };

    remotePlay.openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = mdDoc ''
        Open ports in the firewall for Steam Remote Play.
      '';
    };

    dedicatedServer.openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = mdDoc ''
        Open ports in the firewall for Source Dedicated Server.
      '';
    };

    gamescopeSession = mkOption {
      description = mdDoc "Run a GameScope driven Steam session from your display-manager";
      type = types.submodule {
        options = {
          enable = mkEnableOption (mdDoc "GameScope Session");
          args = mkOption {
            type = types.listOf types.string;
            default = [ ];
            description = mdDoc ''
              Arguments to be passed to GameScope for the session.
            '';
          };

          env = mkOption {
            type = types.attrsOf types.string;
            default = { };
            description = mdDoc ''
              Environmental variables to be passed to GameScope for the session.
            '';
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    hardware.opengl = {
      # this fixes the "glXChooseVisual failed" bug, context: https://github.com/NixOS/nixpkgs/issues/47932
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    security.wrappers = mkIf (cfg.gamescopeSession.enable && gamescopeCfg.capSysNice) {
      # needed or steam fails
      bwrap = {
        owner = "root";
        group = "root";
        source = "${pkgs.bubblewrap}/bin/bwrap";
        setuid = true;
      };
    };

    programs.gamescope.enable = mkDefault cfg.gamescopeSession.enable;
    services.xserver.displayManager.sessionPackages = mkIf cfg.gamescopeSession.enable [ gamescopeSessionFile ];

    # optionally enable 32bit pulseaudio support if pulseaudio is enabled
    hardware.pulseaudio.support32Bit = config.hardware.pulseaudio.enable;

    hardware.steam-hardware.enable = true;

    environment.systemPackages = [
      cfg.package
      cfg.package.run
    ];

    networking.firewall = mkMerge [
      (mkIf cfg.remotePlay.openFirewall {
        allowedTCPPorts = [ 27036 ];
        allowedUDPPortRanges = [{ from = 27031; to = 27036; }];
      })

      (mkIf cfg.dedicatedServer.openFirewall {
        allowedTCPPorts = [ 27015 ]; # SRCDS Rcon port
        allowedUDPPorts = [ 27015 ]; # Gameplay traffic
      })
    ];
  };

  meta.maintainers = with maintainers; [ mkg20001 ];
}