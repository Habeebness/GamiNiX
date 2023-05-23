{
  pkgs,
  config,
  lib,
  ...
}: {
  boot.extraModulePackages = with config.boot.kernelPackages; [
    kvmfr
  ];
  boot.extraModprobeConfig = ''
    options kvmfr static_size_mb=128
  '';

  users.groups.libvirtd.members = ["root" "iggut"];

  boot = {
    kernelModules = [
      "vfio_pci"
      "vfio_iommu_type1"
      "vfio"
      "kvm-intel"
      "amdgpu"
      "kvmfr"
    ];

    kernelParams = [
      "intel_iommu=on"
      "nowatchdog"
      "preempt=voluntary"
      "iommu.passthrough=1"
      "intel_iommu=igfx_off"
      "iommu=pt"
      "video=efifb:off"
      "video=vesafb:off"
      "vfio-pci.ids=10de:2482,10de:228b"
      "quiet"
      "kvm.ignore_msrs=1"
      "kvm.report_ignored_msrs=0"
      "split_lock_detect=off" # https://www.phoronix.com/news/Linux-Splitlock-Hurts-Gaming
    ];

    initrd.kernelModules = [
      "vfio_pci"
      "vfio_iommu_type1"
      "vfio"
      "amdgpu"
    ];

    #extraModprobeConfig = ''
    #  softdep nvidia pre: vfio-pci
    #  softdep nouveau pre: vfio-pci
    #'';
    #blacklistedKernelModules = [
    #  "nvidia"
    #  "nouveau"
    #];
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="vfio", OWNER="root", GROUP="kvm"
    SUBSYSTEM=="kvmfr", OWNER="root", GROUP="libvirtd", MODE="0660"
  '';

  systemd.tmpfiles.rules = ["f /dev/shm/looking-glass 0666 iggut kvm -"];
  environment.sessionVariables.LIBVIRT_DEFAULT_URI = ["qemu:///system"];
  environment.systemPackages = with pkgs;
    lib.mkIf config.virtualisation-settings.docker.enable [
      docker # Containers - Used to create and run containers
      distrobox # Wrapper around docker to create and start linux containers - Tool for creating and managing Linux containers using Docker
      virt-manager # Gui for QEMU/KVM Virtualisation - Graphical user interface for managing QEMU/KVM virtual machines
      gsettings-desktop-schemas
      linuxKernel.packages.linux_6_3.kvmfr
    ];

  virtualisation = {
    libvirtd = {
      enable = true;
      onShutdown = "suspend";
      extraConfig = ''
        user="iggut"
      '';
      qemu = {
        package = pkgs.qemu_full;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMF.fd];
        verbatimConfig = ''
          namespaces = []
          user = "iggut"
          group = "kvm"
          nographics_allow_host_audio = 1
          cgroup_device_acl = [
            "/dev/null", "/dev/full", "/dev/zero",
            "/dev/random", "/dev/urandom", "/dev/ptmx",
          	"/dev/kvm", "/dev/kqemu", "/dev/rtc",
          	"/dev/hpet", "/dev/vfio/vfio", "/dev/kvmfr0",
          	"/dev/vfio/22", "/dev/shm/looking-glass"
          ]
        '';
      };
    };
    podman = {
      autoPrune = {
        enable = true;
        flags = ["--all"];
      };
      dockerCompat = true;
      dockerSocket.enable = true;
      enable = true;
    };
    lxd.enable = config.virtualisation-settings.lxd.enable;
    spiceUSBRedirection.enable = config.virtualisation-settings.spiceUSBRedirection.enable;
    waydroid.enable = config.virtualisation-settings.waydroid.enable;
    #docker.enable = config.virtualisation-settings.docker.enable;
  };

  fonts.fonts = [pkgs.dejavu_fonts]; # Need for looking-glass

  home-manager.users.iggut = {
    programs.looking-glass-client = {
      enable = true;
      settings = {
        #app.shmFile = "/dev/shm/looking-glass";
        app.allowDMA = true;
        app.shmFile = "/dev/kvmfr0";
        win.showFPS = true;
        spice.enable = true;
      };
    };
  };
}
