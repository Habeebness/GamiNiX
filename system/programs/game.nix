{
  pkgs,
  lib,
  user,
  chaotic,
  ...
}: {
  environment.systemPackages = with pkgs; [
    goverlay
    mangohud
    prismlauncher
    lunar-client
    minetest
    osu-lazer-bin
    protonup-qt
    linux_cachyos
    beautyline-icons
    fastfetch
    ananicy-cpp-rules
  ];

  hardware = {
    steam-hardware.enable = true;
    # xpadneo.enable = true;
  };

  # Enable gamemode
  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        softrealtime = "auto";
        renice = 10;
      };
      custom = {
        start = "notify-send -a 'Gamemode' 'Optimizations activated'";
        end = "notify-send -a 'Gamemode' 'Optimizations deactivated'";
      };
    };
  };

  # improvement for games using lots of mmaps (same as steam deck)
  boot.kernel.sysctl = {"vm.max_map_count" = 2147483642;};

  ### Chaotic-LUG ###
  chaotic.linux_hdr.specialisation.enable = true;
  chaotic.appmenu-gtk3-module.enable = true;
  # Unstable gamescope from Chaotic-Nyx
  #chaotic.gamescope = {
  #  enable = true;
  #  package = pkgs.gamescope_git;
  #  args = ["--rt" "--prefer-vk-device 1002:73ff"];
  #  env = {
  #    "__GLX_VENDOR_LIBRARY_NAME" = "amd";
  #    "DRI_PRIME" = "1";
  #    "MESA_VK_DEVICE_SELECT" = "pci:1002:73ff";
  #    "__VK_LAYER_MESA_OVERLAY_CONFIG" = "ld.so.preload";
  #    "DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1" = "1";
  #  };
  #  session = {
  #    enable = true;
  #    args = ["--rt"];
  #    env = {
  #      "__GLX_VENDOR_LIBRARY_NAME" = "amd";
  #      "DRI_PRIME" = "1";
  #      "MESA_VK_DEVICE_SELECT" = "pci:1002:73ff";
  #      "__VK_LAYER_MESA_OVERLAY_CONFIG" = "ld.so.preload";
  #      "DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1" = "1";
  #    };
  #  };
  #};
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  #Enable Gamescope
  programs.gamescope = {
    enable = true;
    package = pkgs.gamescope_git;
    capSysNice = true;
    args = ["--prefer-vk-device 1002:73ff"];
    env = {
      "__GLX_VENDOR_LIBRARY_NAME" = "amd";
      "DRI_PRIME" = "1";
      "MESA_VK_DEVICE_SELECT" = "pci:1002:73ff";
      "__VK_LAYER_MESA_OVERLAY_CONFIG" = "ld.so.preload";
      "DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1" = "1";
    };
  };
  #chaotic.steam.extraCompatPackages = with pkgs; [luxtorpeda proton-ge-custom];
  # Chaotic cache
  nix.settings = {
    extra-substituters = [
      "https://nyx.chaotic.cx"
    ];
    extra-trusted-public-keys = [
      "nyx.chaotic.cx-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
    ];
  };
}
