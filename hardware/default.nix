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
			extraPackages = with pkgs; [ 
				rocm-opencl-icd 
				rocm-opencl-runtime 
				libva 
				libva-utils 
				libvdpau-va-gl 
				vulkan-tools 
				vaapiVdpau 
				];
			enable = true;
			driSupport32Bit = true;
			driSupport = true; # Support Direct Rendering for 32-bit applications (such as Wine) on 64-bit systems
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
  


  # Set CPU Governor
  powerManagement.cpuFreqGovernor = "ondemand";

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
			"v4l2loopback" # Virtual camera
			"xpadneo"
			"uinput"
			"overlay"
		  "fuse" # Disable case-sensitivity in file names
		];
		#postBootCommands = ''
    #  modprobe -r nvidiafb
    #  modprobe -r nouveau
    
    #  echo 0 > /sys/class/vtconsole/vtcon0/bind
    #  echo 0 > /sys/class/vtconsole/vtcon1/bind
    #  echo efi-framebuffer.0 > /sys/bus/platform/drivers/efiframebuffer/unbind
 
    #  DEVS="0000:08:00.0 0000:08:00.1"
 
    #  for DEV in $DEVS; do
    #    echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
    #  done
    #  modprobe -i vfio-pci
    #'';
		# Disable case-sensitivity in file names
		extraModprobeConfig = ''
      options fuse allow_other 
    '';
		extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
	};
	


	#fileSystems = lib.mkIf config.boot.btrfs-compression.enable {
	#	"/".options = [ "compress=zstd" ];
	#};
}
