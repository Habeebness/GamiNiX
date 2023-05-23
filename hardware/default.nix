{
  lib,
  config,
  pkgs,
  ...
}: let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in {
  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
      driSupport = true; # Support Direct Rendering for 32-bit applications (such as Wine) on 64-bit systems
      extraPackages = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
        amdvlk
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };

    #nvidia = {
    #  nvidiaPersistenced = true;
    #  nvidiaSettings = true;
    #  powerManagement.finegrained = true;
    #  prime = {
    #    allowExternalGpu = true;
    #    offload.enable = true;
    #    offload.enableOffloadCmd = true;
    #    amdgpuBusId = "PCI:8:0:0";
    #    nvidiaBusId = "PCI:1:0:0";
    #  };
    #};

    xpadneo.enable = true; # Enable XBOX Gamepad bluetooth driver
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
    uinput.enable = true; # Enable uinput support
  };

  boot = {
    kernelModules = [
      "v4l2loopback" # Virtual camera
      "uinput"
      "fuse"
      "overlay"
    ];
    #    postBootCommands = ''
    #      modprobe -r nvidia
    #      modprobe -r nouveau

    #      echo 0 > /sys/class/vtconsole/vtcon0/bind
    #      echo 0 > /sys/class/vtconsole/vtcon1/bind
    #      echo efi-framebuffer.0 > /sys/bus/platform/drivers/efiframebuffer/unbind

    #      DEVS="0000:01:00.0 0000:01:00.1"

    #      for DEV in $DEVS; do
    #        echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
    #      done
    #      modprobe -i vfio-pci
    #    '';
    extraModprobeConfig = ''
      options fuse allow_other
    '';

    kernelParams = ["clearcpuid=514"]; # Fixes certain wine games crash on launch

    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
  };
}
