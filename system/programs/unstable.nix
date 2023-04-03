### PACKAGES INSTALLED ON ALL USERS ###
{ pkgs, config, ... }:



let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
	environment.systemPackages = with pkgs; [
		#(callPackage ./gamescope.nix {}) # Wayland microcompositor
		(callPackage ./self-built/sfwbar {}) # Status bar for Wayland
		pkgs.gamescope # Wayland microcompositor
		google-chrome # Hate it and love it Browser
		nwg-drawer # Sexy app launcher
		nwg-menu # Sexy app menu
		libxkbcommon
    alsaLib
		libpulseaudio
		libgpgerror
    libgcrypt
	  libbsd
		libdrm
	];
	




}


