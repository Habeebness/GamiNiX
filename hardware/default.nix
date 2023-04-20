{lib, config, pkgs, ...}:

#let
#	nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
#		export __NV_PRIME_RENDER_OFFLOAD=1
#		export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
#		export __GLX_VENDOR_LIBRARY_NAME=nvidia
#		export __VK_LAYER_NV_optimus=NVIDIA_only
#		exec "$@"
#	'';
#in
{
	hardware = {
		opengl = {
			enable = true;
			driSupport32Bit = true;
			driSupport = true; # Support Direct Rendering for 32-bit applications (such as Wine) on 64-bit systems
			extraPackages = with pkgs; [ 
				rocm-opencl-icd 
				rocm-opencl-runtime 
				amdvlk
				mesa.drivers
			];
			extraPackages32 = with pkgs; [ 
				driversi686Linux.amdvlk
			];
		};

		#nvidia = lib.mkIf (config.nvidia.enable && config.nvidia.patch.enable) {
		#	package = config.nur.repos.arc.packages.nvidia-patch.override {
		#		nvidia_x11 = config.boot.kernelPackages.nvidiaPackages.stable;
		#	};# Patch the driver for nvfbc
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
  

	#environment.systemPackages = lib.mkIf (config.laptop.enable && config.nvidia.enable) [ nvidia-offload ]; # Use nvidia-offload to launch programs using the nvidia GPU

	# Set memory limits
	#security.pam.loginLimits =
	#[
	#	{
	#		domain = "*";
	#		type = "hard";
	#		item = "memlock";
	#		value = "2147483648";
	#	}

	#	{
	#		domain = "*";
	#		type = "soft";
	#		item = "memlock";
	#		value = "2147483648";
	#	}
	#];
  boot = {
		kernelModules = [
			"kvm-intel"
			"amdgpu"
			"v4l2loopback" # Virtual camera
			"uinput"
		  "fuse"
			"overlay"
		];
		#postBootCommands = ''
    #  modprobe -r nvidiafb
    #  modprobe -r nouveau
    
    #  echo 0 > /sys/class/vtconsole/vtcon0/bind
    #  echo 0 > /sys/class/vtconsole/vtcon1/bind
    #  echo efi-framebuffer.0 > /sys/bus/platform/drivers/efiframebuffer/unbind
 
    #  DEVS="0000:01:00.0 0000:01:00.1"
 
    #  for DEV in $DEVS; do
    #    echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
    #  done
    #  modprobe -i vfio-pci
    #'';
		extraModprobeConfig = ''
      options fuse allow_other 
    '';
		
		kernelParams = [ "clearcpuid=514" ]; # Fixes certain wine games crash on launch

		extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

		kernel.sysctl = { "vm.max_map_count" = 262144; }; # Fixes crash when loading maps in CS2
	};
	


	#fileSystems = lib.mkIf config.boot.btrfs-compression.enable {
	#	"/".options = [ "compress=zstd" ];
	#};
}
