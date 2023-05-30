### PACKAGES INSTALLED ON ALL USERS ###
{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (callPackage ./self-built/apx.nix {}) # Package manager using distrobox
    (callPackage ./self-built/webcord {}) # An open source discord client
    #(firefox.override {extraNativeMessagingHosts = [(callPackage ./self-built/pipewire-screenaudio {})];}) # Browser
    (pkgs.wrapOBS {plugins = with pkgs.obs-studio-plugins; [obs-pipewire-audio-capture];}) # Pipewire audio plugin for OBS Studio
    (callPackage ./self-built/sfwbar {}) # Status bar for Wayland
    (callPackage ./self-built/nwg-panel {}) # Status bar for Wayland
    (tesseract4.override {enableLanguages = ["fra" "eng"];})
    age-plugin-yubikey
    google-chrome # Hate it and love it Browser
    glxinfo
    nss
    morgen # All-in-one Calendars, Tasks and Scheduler
    ananicy-cpp-rules
    android-tools # Tools for debugging android devices
    appimage-run # Appimage runner
    samba4Full # Samba server to share files/printers with windows
    aria # Terminal downloader with multiple connections support
    bat # Better cat command
    btop # System monitor
    cargo # Rust package manager
    discord # Chat client
    cinnamon.warpinator # Local file sync
    curtail # Image compressor
    direnv # Unclutter your .profile
    efibootmgr # Edit EFI entries
    #firefox # Browser
    gcc # C compiler
    gimp # Image editor
    git # Distributed version control system
    gping # ping with a graph
    #gscan2pdf # Gnome scanning software
    helvum # Pipewire patchbay
    jq # JSON parser
    killall # Tool to kill all programs matching process name
    kitty # Terminal
    lsd # Better ls command
    lynis # Run security analysis
    mpv # Video player
    vlc # Video player
    neofetch # pc info
    libnotify # Send desktop notifications
    bc # Arbitrary precision calculator language
    pciutils # I need me some lspci
    mullvad-vpn # VPN Client
    neovim # Terminal text editor
    nodejs # Node package manager
    ntfs3g # Support NTFS drives
    obs-studio # Recording/Livestream
    onlyoffice-bin # Microsoft Office alternative for Linux
    p7zip # 7zip
    pam_u2f
    python3 # Python
    ranger # Terminal file manager
    rnnoise-plugin # A real-time noise suppression plugin
    scribus # Desktop Publishing (DTP) and Layout program for Linux
    signal-desktop # Encrypted messaging platform
    sublime4 # Text editor
    #tmux # Terminal multiplexer
    tree # Display folder content at a tree format
    unrar # Support opening rar files
    wget # Terminal downloader
    lutris # Windows gaming
    pulseaudio # Sound server for Linux-based systems
    tesseract4
    gImageReader
    wine # Compatibility layer capable of running Windows applications
    winetricks # Wine prefix settings manager
    woeusb # Windows ISO Burner
    xorg.xhost # Use x.org server with distrobox
    yubikey-manager
    yubikey-manager-qt
    yubioath-flutter
    yubico-pam
    yubikey-personalization
    zerotierone # Virtual lan network
    ###
    _1password-gui
    age
    bind
    bitwarden-cli
    cached-nix-shell
    cachix
    cloudflared
    colmena
    curl
    duf
    fastfetch
    micro
    nettools
    nmap
    pinentry-curses
    tldr
    traceroute
    ugrep
    wget
    whois
    ###
    acpi
    appimage-run
    asciinema
    aspell
    aspellDicts.de
    aspellDicts.en
    #chromium
    ffmpegthumbnailer
    gimp
    helvum
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    inkscape
    krita
    libreoffice-qt
    libsForQt5.kdenlive
    libsForQt5.kleopatra
    libsForQt5.krdc
    libsForQt5.krfb
    libsecret
    libva-utils
    lm_sensors
    movit
    nextcloud-client
    nheko
    qbittorrent
    spotify
    tdesktop
    tor-browser-bundle-bin
    usbutils
    vorta
    vulkan-tools
    xdg-ninja
    ansible
    bind.dnsutils
    gitkraken
    heroku
    hugo
    jetbrains.pycharm-professional
    keybase-gui
    nixos-generators
    nixpkgs-fmt
    nixpkgs-lint
    nixpkgs-review
    nodejs
    ruff
    shellcheck
    shfmt
    speedcrunch
    statix
    termius
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions;
        [
          b4dm4n.vscode-nixpkgs-fmt
          bbenoist.nix
          eamodio.gitlens
          esbenp.prettier-vscode
          foxundermoon.shell-format
          github.codespaces
          github.copilot
          github.vscode-github-actions
          ms-azuretools.vscode-docker
          ms-python.python
          ms-python.vscode-pylance
          ms-vscode.hexeditor
          ms-vsliveshare.vsliveshare
          njpwerner.autodocstring
          pkief.material-icon-theme
          redhat.vscode-xml
          redhat.vscode-yaml
          timonwong.shellcheck
          tyriar.sort-lines
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "sweet-vscode";
            publisher = "eliverlara";
            sha256 = "sha256-kJgqMEJHyYF3GDxe1rnpTEmbfJE01tyyOFjRUp4SOds=";
            version = "1.1.1";
          }
          {
            name = "ruff";
            publisher = "charliermarsh";
            sha256 = "sha256-2FAq5jEbnQbfXa7O9O231aun/pJ8mkoBf1u4ekkBQu8=";
            version = "2023.13.10931546";
          }
        ];
    })
    xdg-utils
    yarn
  ];

  users.defaultUserShell = pkgs.zsh; # Use ZSH shell for all users

  boot.kernel.sysctl = {
    # The Magic SysRq key is a key combo that allows users connected to the
    # system console of a Linux kernel to perform some low-level commands.
    # Disable it, since we don't need it, and is a potential security concern.
    "kernel.sysrq" = 0;
    # Restrict ptrace() usage to processes with a pre-defined relationship
    # (e.g., parent/child)
    "kernel.yama.ptrace_scope" = 2;
    # Hide kptrs even for processes with CAP_SYSLOG
    "kernel.kptr_restrict" = 2;
    # Disable ftrace debugging
    "kernel.ftrace_enabled" = false;
  };

  boot.blacklistedKernelModules = [
    # Obscure network protocols
    "ax25"
    "netrom"
    "rose"
    # Old or rare or insufficiently audited filesystems
    "adfs"
    "affs"
    "befs"
    "bfs"
    "btusb"
    "cifs"
    "cramfs"
    "cramfs"
    "efs"
    "erofs"
    "exofs"
    "f2fs"
    "freevxfs"
    "freevxfs"
    "gfs2"
    "hfs"
    "hfsplus"
    "hpfs"
    "jffs2"
    "jfs"
    "ksmbd"
    "minix"
    "nfs"
    "nfsv3"
    "nfsv4"
    "nilfs2"
    "omfs"
    "qnx4"
    "qnx6"
    "sysv"
    "udf"
    "vivid"
  ];
  # The hardening profile enables Apparmor by default, we don't want this to happen
  security.apparmor.enable = false;
  # Don't lock kernel modules, this is also enabled by the hardening profile by default
  security.lockKernelModules = false;
  # Disable coredumps
  systemd.coredump.enable = false;
  programs = {
    #Basic chromium settings (system-wide)
    chromium = {
      defaultSearchProviderEnabled = true;
      defaultSearchProviderSearchURL = "https://www.google.com/search?q=%s";
      defaultSearchProviderSuggestURL = "https://www.google.com/autocomplete?q=%s";
      enable = true;
      extensions = [
        "ajhmfdgkijocedmfjonnpjfojldioehi" # Privacy Pass
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock origin
        "hipekcciheckooncpjeljhnekcoolahp" # Tabliss
        "kbfnbcaeplbcioakkpcpgfkobkghlhen" # Grammarly
        "mdjildafknihdffpkfmmpnpoiajfjnjd" # Consent-O-Matic
        "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
        "njdfdhgcmkocbgbhcioffdbicglldapd" # LocalCDN
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      ];
      extraOpts = {
        "HomepageLocation" = "https://www.google.com";
        "QuicAllowed" = true;
        "RestoreOnStartup" = true;
        "ShowHomeButton" = true;
      };
    };

    # In case I need to fix my phone & Waydroid
    adb.enable = true;

    # Prevent TOFU MITM
    ssh.knownHosts = {
      github-rsa.hostNames = ["github.com"];
      github-rsa.publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgAR+aHGaiM1ymGCClBqKId6PmkT4fKKc1cpBx+sNcRyS74AsgHoRGEq+fmzRZs2vVsd2XDbr5wzTmg0AxA9VCZ1HAnBPpS89BM9WzrfeVKboIZbmyDvRr0KDKu5tDjsmOjBU4WdZcjh+K8KNjdN/xfi9hNcBQvUBeu7mpvoxu6AOb2Q2xnO0WNhOBRyt3mrjnwgGVLWcFz73vEbX/HcyVMr+iTH5952+6J/jNm0/hYNHrXE4cRaooQZ4fjwMj9I7y/qYHrQ3p4wYh5SG2mRX39sPQ7Nhe3x2IPmBes7B4NYMFuGANHNZYSDewwslJUssH1WFFVppiQM32cxIPLFfSs2VckLIVwKIc5qGvSk912RhQ42kuOOTWTS3yJxU+yVt+L+ffTpRsWMnukWnnZg8kSPVGG0sTbbHNP04k9BS6Y9uwF4vgi5nXOjGofmPfMdeTP6X89NPLeApdBZArS30Z037e5PFqinmtLwIn2O0KgHBQPEZUdTHrWIlZ8wuG/6k=";
      github-ed25519.hostNames = ["github.com"];
      github-ed25519.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBUYnAPuFC2bnrIHM8DiweTJThqZV9fjZMmI5Rx6bgw7";
      gitlab-rsa.hostNames = ["gitlab.com"];
      gitlab-rsa.publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgAR+aHGaiM1ymGCClBqKId6PmkT4fKKc1cpBx+sNcRyS74AsgHoRGEq+fmzRZs2vVsd2XDbr5wzTmg0AxA9VCZ1HAnBPpS89BM9WzrfeVKboIZbmyDvRr0KDKu5tDjsmOjBU4WdZcjh+K8KNjdN/xfi9hNcBQvUBeu7mpvoxu6AOb2Q2xnO0WNhOBRyt3mrjnwgGVLWcFz73vEbX/HcyVMr+iTH5952+6J/jNm0/hYNHrXE4cRaooQZ4fjwMj9I7y/qYHrQ3p4wYh5SG2mRX39sPQ7Nhe3x2IPmBes7B4NYMFuGANHNZYSDewwslJUssH1WFFVppiQM32cxIPLFfSs2VckLIVwKIc5qGvSk912RhQ42kuOOTWTS3yJxU+yVt+L+ffTpRsWMnukWnnZg8kSPVGG0sTbbHNP04k9BS6Y9uwF4vgi5nXOjGofmPfMdeTP6X89NPLeApdBZArS30Z037e5PFqinmtLwIn2O0KgHBQPEZUdTHrWIlZ8wuG/6k=";
      gitlab-ed25519.hostNames = ["gitlab.com"];
      gitlab-ed25519.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBUYnAPuFC2bnrIHM8DiweTJThqZV9fjZMmI5Rx6bgw7";
    };

    # Enable Firejail
    firejail = {
      enable = true;
      wrappedBinaries = {
        google-chrome = {
          executable = "${pkgs.google-chrome}/opt/google/chrome/google-chrome";
          profile = "${pkgs.firejail}/etc/firejail/google-chrome.profile";
          extraArgs = [
            "--dbus-user.talk=org.freedesktop.Notifications"
            "--env=GTK_THEME=Sweet-dark:dark"
            "--ignore=private-dev"
          ];
        };
      };
    };

    zsh = {
      enable = true;
      # Enable oh my zsh and it's plugins
      ohMyZsh = {
        enable = true;
        plugins = ["git" "npm" "nvm" "sudo" "systemd"];
      };
      autosuggestions.enable = true;

      syntaxHighlighting.enable = true;

      # Aliases
      shellAliases = {
        apx = "apx --aur"; # Use arch as the base apx container
        aria2c = "aria2c -j 16 -s 16"; # Download with aria using best settings
        btrfs-compress = "sudo btrfs filesystem defrag -czstd -r -v"; # Compress given path with zstd
        cat = "bat"; # Better cat command
        chmod = "sudo chmod"; # It's a command that I always execute with sudo
        clear-keys = "sudo rm -rf ~/ local/share/keyrings/* ~/ local/share/kwalletd/*"; # Clear system keys
        cp = "rsync -rP"; # Copy command with details
        desktop-files-list = "ls -l /run/current-system/sw/share/applications"; # Show desktop files location
        gamesteam = "gamescope -e -w 1920 -h 1080 -f -- steam -tenfoot";
        list-packages = "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq"; # List installed nix packages
        looking-game = "gamescope -w 1920 -h 1080 -fU -- looking-glass-client -m KEY_INSERT -F"; # Looking-glass using gamescope
        ls = "lsd"; # Better ls command
        mva = "rsync -rP --remove-source-files"; # Move command with details
        n = "(tmux a -t nvchad || tmux  new -s nvchad nvim) 2> /dev/null"; # Nvchad
        nix-gc = "nix-store --gc"; # Garbace collect for the nix store
        ping = "gping"; # ping with a graph
        #reboot-windows="sudo efibootmgr --bootnext ${config.boot.windows-entry} && reboot"; # Reboot to windows
        rebuild = "(cd $(head -1 /etc/nixos/.configuration-location) 2> /dev/null || (echo 'Configuration path is invalid. Run rebuild.sh manually to update the path!' && false) && bash rebuild.sh)"; # Rebuild the system configuration
        restart-pipewire = "systemctl --user restart pipewire"; # Restart pipewire
        server = "ssh server@192.168.1.2"; # Connect to local server
        ssh = "TERM=xterm-256color ssh"; # SSH with colors
        steam-link = "killall steam 2> /dev/null ; while ps axg | grep -vw grep | grep -w steam > /dev/null; do sleep 1; done && (nohup steam -pipewire > /dev/null &) 2> /dev/null"; # Kill existing steam process and relaunch steam with the pipewire flag
        updateall = "(cd $(head -1 /etc/nixos/.configuration-location) 2> /dev/null || (echo 'Configuration path is invalid. Run rebuild.sh manually to update the path!' && false) && sudo nix flake update && bash rebuild.sh) ; (apx --aur upgrade) ; (bash ~/.config/zsh/proton-ge-updater.sh) ; (bash ~/.config/zsh/steam-library-patcher.sh)"; # Update everything
        update = "(apx --aur upgrade) ; (bash ~/.config/zsh/proton-ge-updater.sh) ; (bash ~/.config/zsh/steam-library-patcher.sh)";
        vpn-btop = "ssh -t server@192.168.1.2 'bpytop'"; # Show VPN bpytop
        vpn-off = "ssh -f server@192.168.1.2 'mullvad disconnect && sleep 1 && mullvad status'"; # Disconnect from VPN
        vpn-on = "ssh -f server@192.168.1.2 'mullvad connect && sleep 1 && mullvad status'"; # Connect to VPN
        vpn = "ssh -f server@192.168.1.2 'mullvad status'"; # Show VPN status
      };

      interactiveShellInit = "source ~/.config/zsh/zsh-theme.zsh\nunsetopt PROMPT_SP"; # Commands to run on zsh shell initialization
    };
  };

  # Automatically tune nice levels
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
  };

  # Get notifications about earlyoom actions
  services.systembus-notify.enable = true;

  # 90% ZRAM as swap
  zramSwap = {
    algorithm = "zstd";
    enable = true;
    memoryPercent = 90;
  };

  # Earlyoom to prevent OOM situations
  services.earlyoom = {
    enable = true;
    enableNotifications = true;
    freeMemThreshold = 5;
  };

  # Tune the Zen kernel
  programs.cfs-zen-tweaks.enable = true;

  ## A few other kernel tweaks
  boot.kernel.sysctl = {
    "kernel.nmi_watchdog" = 0;
    "kernel.sched_cfs_bandwidth_slice_us" = 3000;
    "net.core.rmem_max" = 2500000;
    "vm.swappiness" = 60;
  };

  # Enable the tor network
  services.tor = {
    client.dns.enable = true;
    client.enable = true;
    enable = true;
    torsocks.enable = true;
  };

  # Enable the smartcard daemon
  hardware.gpgSmartcards.enable = true;
  services.pcscd.enable = true;
  services.udev.packages = [pkgs.yubikey-personalization];

  # Configure as challenge-response for instant login,
  # can't provide the secrets as the challenge gets updated
  security.pam.yubico = {
    debug = true;
    enable = true;
    mode = "challenge-response";
    id = [ "23911227" ];
  };

  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  services = {
    openssh.enable = true;
    mullvad-vpn.enable = true;
  };

  # Symlink files and folders to /etc
  environment.etc."rnnoise-plugin/librnnoise_ladspa.so".source = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
  environment.etc."proton-ge-nix".source = "${(pkgs.callPackage self-built/proton-ge.nix {})}/";
  environment.etc."apx/config.json".source = "${(pkgs.callPackage self-built/apx.nix {})}/etc/apx/config.json";
}
