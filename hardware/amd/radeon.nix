{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.amd.gpu.enable {
  #boot.initrd.kernelModules = ["amdgpu"]; # Use the amdgpu drivers upon boot

  services.xserver.videoDrivers = ["amdgpu"];
  # RADV video decode & general usage
  environment.variables = {
    AMD_VULKAN_ICD = "RADV";
    RADV_VIDEO_DECODE = "1";
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
  ];

  programs.corectrl = {
    enable = true;
    gpuOverclock = {
      enable = true;
      ppfeaturemask = "0xffffffff"; # Unlock all gpu controls
    };
  };

  # Do not ask for password when launching corectrl
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
    		if ((action.id == "org.corectrl.helper.init" ||
    		action.id == "org.corectrl.helperkiller.init") &&
    		subject.local == true &&
    		subject.active == true &&
    		subject.isInGroup("users")) {
    			return polkit.Result.YES;
    	}
    });
  '';
  chaotic.mesa-git.enable = false;
  environment.systemPackages = with pkgs; [
    radeon-profile
    corectrl # GPU overclocking tool
    nvtop-amd # GPU task manager
  ];
}
