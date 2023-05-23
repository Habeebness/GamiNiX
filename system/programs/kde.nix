{
  config,
  lib,
  pkgs,
  ...
}:
with builtins; let
  immutable = false;

  configDir = ".config";
  kvantumDir = ".config/Kvantum";
  localDir = ".local/share";

  # JamesDSP Dolby presets
  game = fetchurl {
    url = "https://cloud.garudalinux.org/s/eimgmWmN485tHGw/download/game.irs";
    sha256 = "0d1lfbzca6wqfqxd6knzshc00khhgfqmk36s5xf1wyh703sdxk79";
  };
  movie = fetchurl {
    url = "https://cloud.garudalinux.org/s/K8CpHZYTiLyXLSd/download/movie.irs";
    sha256 = "1r3s8crbmvzm71yqrkp8d8x4xyd3najz82ck6vbh1v9kq6jclc0w";
  };
  music = fetchurl {
    url = "https://cloud.garudalinux.org/s/cbPLFeAMeJazKxC/download/music-balanced.irs";
    sha256 = "1szssbqk3dnaqhg3syrzq9zqfb18phph5yy5m3xfnjgllj2yphy0";
  };
  voice = fetchurl {
    url = "https://cloud.garudalinux.org/s/wJSs9gckrNidTBo/download/voice.irs";
    sha256 = "1b643m8v7j15ixi2g6r2909vwkq05wi74ybccbdnp4rkms640y4w";
  };
in {
  # Theme our desktop launchers
  imports = [./theme-launchers.nix];

  # Disable GTK target for Stylix as we supply KDE built files
  stylix.targets.gtk.enable = true;
}
