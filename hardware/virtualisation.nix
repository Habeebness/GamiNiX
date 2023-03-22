{ pkgs, config, lib, ... }:

{
	virtualisation = {
		docker.enable = config.virtualisation-settings.docker.enable;
		libvirtd.enable = config.virtualisation-settings.libvirtd.enable;
		libvirtd.qemu.swtpm.enable = config.virtualisation-settings.libvirtd.enable;
		lxd.enable = config.virtualisation-settings.lxd.enable;
		spiceUSBRedirection.enable = config.virtualisation-settings.spiceUSBRedirection.enable;
		waydroid.enable = config.virtualisation-settings.waydroid.enable;
	};

  #boot.initrd.kernelModules = [ "amdgpu" ]; # Boot gpu drivers
  boot = {
		kernelModules = [ "kvm-intel" ];
		kernelParams = [ 
		  "intel_iommu=on"
		  "module_blacklist=i915"
		  "module_blacklist=nvidia" 
		  "module_blacklist=nouveau" 
	  ];
	};
	environment.systemPackages = with pkgs; lib.mkIf config.virtualisation-settings.docker.enable [
		docker # Containers
		distrobox # Wrapper around docker to create and start linux containers
		spice
		spice-gtk
		spice-vdagent
		spice-protocol
		virt-manager # Gui for QEMU/KVM Virtualisation 
		looking-glass-client # VM client
		win-virtio
		win-spice
	];
}
