{ pkgs, config, lib, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
	

	
  users.groups.libvirtd.members = [ "root" "iggut" ];

  boot = {
		kernelModules = [ 
			"vfio_pci" 
			"vfio_iommu_type1" 
			"vfio" 
			"kvm-intel"
      "vfio_mdev"
		];

		kernelParams = [ 
		  "intel_iommu=on"
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
      "splash"
	  ];

		initrd.kernelModules = [ 
			"vfio_pci" 
			"vfio_iommu_type1" 
			"vfio" 
			"amdgpu" 
		];
		
		blacklistedKernelModules = [ 
			"nvidia" 
			"nouveau" 
		];
	};
  

  boot.extraModprobeConfig = ''
	  softdep nvidia pre: vfio-pci
		softdep nouveau pre: vfio-pci
    softdep snd_hda_intel pre: vfio-pci 
    options vfio_pci disable_vga=1
    options vfio-pci ids=10de:2482,10de:228b
    options kvm ignore_msrs=1
  '';

  services.udev.extraRules = ''SUBSYSTEM=="vfio", OWNER="root", GROUP="kvm"'';
	programs.dconf.enable = true;
	systemd.tmpfiles.rules = [ "f /dev/shm/looking-glass 0666 iggut kvm -" ];

	environment.systemPackages = with pkgs; lib.mkIf config.virtualisation-settings.docker.enable [
		#pkgs.linuxKernel.packages.linux_xanmod_latest.kvmfr
		docker # Containers
		distrobox # Wrapper around docker to create and start linux containers
		spice
		spice-gtk
		spice-vdagent
		spice-protocol
		virt-manager # Gui for QEMU/KVM Virtualisation 
		#looking-glass-client # VM client
		win-virtio
		win-spice
	];

	virtualisation = {

		libvirtd = {
      enable = true;
			extraConfig = ''
        user="iggut"
      '';
      qemu = {
				package = pkgs.qemu_kvm;
        runAsRoot = true;
			  swtpm.enable = true;
        ovmf.enable = true; 
				verbatimConfig = ''
        namespaces = []
				user = "iggut"
				group = "kvm"
        nographics_allow_host_audio = 1
				cgroup_device_acl = [
        "/dev/null", "/dev/full", "/dev/zero",
        "/dev/random", "/dev/urandom", "/dev/ptmx",
				"/dev/kvm", "/dev/kqemu", "/dev/rtc",
				"/dev/hpet", "/dev/vfio/vfio",
				"/dev/vfio/22", "/dev/shm/looking-glass"
        ]
        '';
			};

    };
		lxd.enable = config.virtualisation-settings.lxd.enable;
		spiceUSBRedirection.enable = config.virtualisation-settings.spiceUSBRedirection.enable;
		waydroid.enable = config.virtualisation-settings.waydroid.enable;
		docker.enable = config.virtualisation-settings.docker.enable;
	};

	fonts.fonts = [ pkgs.dejavu_fonts ]; # Need for looking-glass

	home-manager.users.iggut = {
      programs.looking-glass-client = {
        enable = true;
        settings = {
          app.shmFile = "/dev/shm/looking-glass";
          win.showFPS = true;
          spice.enable = true;
        };
      };
  };

}




