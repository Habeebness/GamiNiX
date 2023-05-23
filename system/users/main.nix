{
  config,
  lib,
  ...
}:
lib.mkIf config.main.user.enable {
  users.users.${config.main.user.username} = {
    createHome = true;
    home = "/home/${config.main.user.username}";
    useDefaultShell = true;
    #password = "x"; # Default password used for first login, change later with passwd
    isNormalUser = true;
    description = "${config.main.user.description}";
    extraGroups = [
      "wheel"
      "libvirtd"
      "kvm"
      "audio"
      "networkmanager"
      "video"
      "docker"
      "media"
      "input"
    ];
  };
  services.dbus.enable = true;

  home-manager.users.${config.main.user.username}.home = {
    stateVersion = "22.11";
    file.".nix-successful-build" = {
      text = "true";
      recursive = true;
    };
  };
}
