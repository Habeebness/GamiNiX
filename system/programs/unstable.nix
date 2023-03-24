### PACKAGES INSTALLED ON ALL USERS ###
{ pkgs, config, ... }:



let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
	environment.systemPackages = with pkgs; [
		(callPackage ./sfwbar.nix {}) # Package manager using distrobox
		google-chrome # Hate it and love it Browser
		nwg-drawer # Sexy App launcher
		libxkbcommon
    alsaLib
		libpulseaudio
		libgpgerror
    libgcrypt
	  libbsd
		libdrm
	];



}
