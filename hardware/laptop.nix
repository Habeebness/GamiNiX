{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.laptop.enable {
  services.auto-cpufreq.enable = true;
  environment.systemPackages = [pkgs.brightnessctl];

  hardware.nvidia.prime = lib.mkIf config.nvidia.enable {
    offload.enable = true;
    amdgpuBusId = "PCI:8:0:0";
    nvidiaBusId = "PCI:1:0:0";
  };
}
