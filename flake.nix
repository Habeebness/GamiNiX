{
  inputs = {
    hyprland.url = "github:hyprwm/Hyprland";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nur.url = "github:nix-community/NUR";
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    # Secrets management
    sops-nix.url = "github:Mic92/sops-nix";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # The Chaotic toolbox
    src-chaotic-toolbox = {
      flake = false;
      url = "github:chaotic-aur/toolbox";
    };
    src-repoctl = {
      flake = false;
      url = "github:cassava/repoctl";
    };

    # Automated system themes
    stylix.url = "github:danth/stylix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    sops-nix,
    chaotic,
    hyprland,
    home-manager,
    nur,
    stylix,
    alejandra,
    ...
  }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        nur.nixosModules.nur
        home-manager.nixosModules.home-manager
        sops-nix.nixosModules.sops
        hyprland.nixosModules.default
        stylix.nixosModules.stylix
        {programs.hyprland.enable = true;}
        ./configuration.nix
        chaotic.nixosModules.default # OUR DEFAULT MODULE
        {
          environment.systemPackages = [alejandra];
        }

        {
          nixpkgs.config.permittedInsecurePackages = [
            "openssl-1.1.1t"
          ];
        }
      ];
    };
  };
}
