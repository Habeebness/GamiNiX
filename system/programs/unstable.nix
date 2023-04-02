### PACKAGES INSTALLED ON ALL USERS ###
{ pkgs, config, ... }:



let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
	environment.systemPackages = with pkgs; [
		(callPackage ./self-built/sfwbar {}) # status bar - wayland
		#(callPackage ./self-built/usbreset {}) # USBreset
		google-chrome # Hate it and love it Browser
		nwg-drawer # Sexy App launcher
		nwg-menu
		gamescope
		libxkbcommon
    alsaLib
		libpulseaudio
		libgpgerror
    libgcrypt
	  libbsd
		libdrm
	];



}
