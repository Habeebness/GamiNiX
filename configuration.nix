{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    # Custom configuration
    ./.nix
    ./bootloader
    ./hardware # Enable various hardware capabilities
    ./hardware/amd/radeon.nix
    ./hardware/intel.nix
    #./hardware/laptop.nix
    ./hardware/mounts.nix # Disks to mount on startup
    #./hardware/nvidia.nix
    ./hardware/virtualisation.nix
    ./system/desktop
    ./system/desktop/gnome
    ./system/desktop/hyprland
    ./system/programs
    ./system/users
  ];

  config.system.stateVersion = "22.11"; # Do not change without checking the docs
}
