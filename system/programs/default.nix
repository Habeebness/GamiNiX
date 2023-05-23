{
  imports = [
    # Packages installed for all users
    ./global.nix
    ./game.nix
    #./self-built/steam.nix
    #./self-built/gamescope.nix
    # Packages installed for main user
    ./main.nix
    ./kde.nix
    # Home manager specific stuff
    ./home-main.nix
  ];

  nix = {
    # This will additionally add your inputs to the system's legacy channels
    # making legacy nix commands consistent as well, awesome!
    #nixPath = mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;
    settings = {
      # Use available binary caches, this is not Gentoo
      # this also allows us to use remote builders to reduce build times and batter usage
      builders-use-substitutes = true;
      # A few extra binary caches and their public keys
      extra-substituters = [
        "https://colmena.cachix.org"
        "https://dr460nf1r3.cachix.org"
        "https://garuda-linux.cachix.org"
        "https://nix-community.cachix.org"
        "https://nixpkgs-unfree.cachix.org"
        "https://nyx.chaotic.cx"
      ];
      extra-trusted-public-keys = [
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
        "dr460nf1r3.cachix.org-1:ujkI5l3i3m6Jh3J8phRXtnUbKdrn7JIxb/dPAO3ePbI="
        "garuda-linux.cachix.org-1:tWw7YBE6qZae0L6BbyNrHo8G8L4sHu5QoDp0OXv70bg="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
        "nyx.chaotic.cx-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      ];
      auto-optimise-store = true; # Use hard links to save space (slows down package manager)
      experimental-features = ["nix-command" "flakes" "recursive-nix" "ca-derivations"]; # Enable flakes
      #substituters = [ "https://hyprland.cachix.org"  ]; # Hyprland cachix
      #trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      system-features = ["big-parallel" "kvm" "recursive-nix"];
      keep-going = true;
      keep-derivations = true;
      keep-outputs = true;
      max-jobs = "auto";
    };

    # Automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  nixpkgs.config = {
    allowUnfree = true; # Allow proprietary packages
  };
}
