{ lib, ... }:

{
	options = {
		mounts.enable = lib.mkOption {
			type = lib.types.bool;
			default = true;
		}; # Set to false if hardware/mounts.nix is not correctly configured

		boot = {
			animation.enable = lib.mkOption {
				type = lib.types.bool;
				default = false;
			}; # Hides startup text and displays a circular loading icon

			autologin = {
				enable = lib.mkOption {
					type = lib.types.bool;
					default = true;
				};

				main.user.enable = lib.mkOption {
					type = lib.types.bool;
					default = true;
				}; # If false, defaults to work user
			};

		    #windows-entry = lib.mkOption {
			    #type = lib.types.str;
			    #default = "0000";
			  #}; # Used for rebooting to windows with efibootmgr

			  #btrfs-compression.enable = lib.mkOption {
			    #type = lib.types.bool;
			    #default = true;
			  #}; # Btrfs compression
		};

		# Declare users
		main.user = {
			enable = lib.mkOption {
				type = lib.types.bool;
				default = true;
			};

			username = lib.mkOption {
				type = lib.types.str;
				default = "iggut";
			};

			description = lib.mkOption {
				type = lib.types.str;
				default = "Igor Gu";
			};

			github = {
				username = lib.mkOption {
					type = lib.types.str;
					default = "IgguT";
				};

				email = lib.mkOption {
					type = lib.types.str;
					default = "igor.gutchin@gmail.com";
				};
			};
		};

		work.user = {
			enable = lib.mkOption {
				type = lib.types.bool;
				default = false;
			};

			username = lib.mkOption {
				type = lib.types.str;
				default = "work";
			};

			description = lib.mkOption {
				type = lib.types.str;
				default = "Work";
			};

			github = {
				username = lib.mkOption {
					type = lib.types.str;
					default = "IgguT";
				};

				email = lib.mkOption {
					type = lib.types.str;
					default = "igor.gutchin@gmail.com";
				};
			};
		};

		amd = {
			gpu.enable = lib.mkOption {
				type = lib.types.bool;
				default = true;
			};
		};

		nvidia = {
			enable = lib.mkOption {
				type = lib.types.bool;
				default = false;
			};



			patch.enable = lib.mkOption {
				type = lib.types.bool;
				default = false;
			};
		};

		intel.enable = lib.mkOption {
			type = lib.types.bool;
			default = true;
		};

		laptop.enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
		};

		virtualisation-settings = {
			docker.enable = lib.mkOption {
				type = lib.types.bool;
				default = true;
			}; # Container manager

			libvirtd.enable = lib.mkOption {
				type = lib.types.bool;
				default = true;
			}; # A daemon that manages virtual machines

			lxd.enable = lib.mkOption {
				type = lib.types.bool;
				default = true;
			}; # Container daemon

			spiceUSBRedirection.enable = lib.mkOption {
				type = lib.types.bool;
				default = true;
			}; # Passthrough USB devices to vms

			waydroid.enable = lib.mkOption {
				type = lib.types.bool;
				default = true;
			}; # Android container
		};

		desktop-environment = {
			gnome = {
				enable = lib.mkOption {
					type = lib.types.bool;
					default = false;
				};

				configuration = {
					clock-date.enable = lib.mkOption {
						type = lib.types.bool;
						default = false;
					};

					caffeine.enable = lib.mkOption {
						type = lib.types.bool;
						default = true;
					};

					startup-items.enable = lib.mkOption {
						type = lib.types.bool;
						default = false;
					};

					pinned-apps = {
						arcmenu.enable = lib.mkOption {
							type = lib.types.bool;
							default = false;
						};

						dash-to-panel.enable = lib.mkOption {
							type = lib.types.bool;
							default = false;
						};
					};
				};
			};

			hyprland.enable = lib.mkOption {
				type = lib.types.bool;
				default = true;
			};

			gdm.auto-suspend.enable = lib.mkOption {
				type = lib.types.bool;
				default = false;
			};
		};

		firefox-privacy.enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
		};

		steam.beta.enable = lib.mkOption {
			type = lib.types.bool;
			default = true;
		};
	};
}
