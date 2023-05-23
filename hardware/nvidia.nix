{
  config,
  pkgs,
  lib,
  ...
}:
lib.mkIf config.nvidia.enable {
  services.xserver.videoDrivers = ["nvidia"]; # Install the nvidia drivers

  hardware.nvidia.prime = lib.mkIf config.nvidia.enable {
    offload.enable = true;
    amdgpuBusId = "PCI:8:0:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  hardware.nvidia.modesetting.enable = true; # Required for wayland

  virtualisation.docker.enableNvidia = true; # Enable nvidia gpu acceleration for docker

  environment.systemPackages = [pkgs.nvtop-nvidia]; # Monitoring tool for nvidia GPUs
}
