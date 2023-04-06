### PACKAGES INSTALLED ON ALL USERS ###
{ pkgs, config, ... }:



let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {

	environment.systemPackages = with pkgs; [
    (callPackage ./self-built/sfwbar {})    # Status bar for Wayland
    gamescope                               # Wayland microcompositor
    google-chrome                           # Hate it and love it Browser
    nwg-drawer                              # Sexy app launcher
    nwg-menu                                # Sexy app menu
    libxkbcommon                            # Keyboard handling library for X11 and Wayland
    alsaLib                                 # ALSA (Advanced Linux Sound Architecture) library
    libpulseaudio                           # PulseAudio sound server library
    libgpgerror                             # GnuPG error codes library
    libgcrypt                               # Cryptographic library for data encryption and decryption
    libbsd                                  # Library providing useful functions commonly found on BSD systems
    libdrm                                  # Library for managing DRM (Direct Rendering Manager) devices
	];
	




}




