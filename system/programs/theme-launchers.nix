{pkgs, ...}: let
  appdir = ".local/share/applications";
in {
  # All of these either have no BeautyLine icon or their description sucks

  # home.file."${appdir}/com.yubico.authenticator.desktop".text = ''
  #   [Desktop Entry]
  #   Categories=Utility;
  #   Comment=Use the Yubikey for OTP's
  #   Exec=${pkgs.yubioath-flutter}/bin/yubioath-flutter
  #   GenericName=Yubico Authenticator
  #   Icon=keysmith
  #   Keywords=Yubico;Authenticator;
  #   Name=Yubico Authenticator
  #   NoDisplay=false
  #   Path=
  #   StartupNotify=true
  #   Terminal=false
  #   TerminalOptions=
  #   Type=Application
  #   X-KDE-SubstituteUID=false
  #   X-KDE-Username=
  # '';

  # home.file."${appdir}/org.prismlauncher.PrismLauncher.desktop".text = ''
  #   [Desktop Entry]
  #   Categories=Game;ActionGame;AdventureGame;Simulation;
  #   Comment=A custom launcher for Minecraft that allows you to easily manage multiple installations of Minecraft at once.
  #   Exec=${pkgs.prismlauncher-mod}/bin/prismlauncher
  #   Icon=minecraft
  #   Keywords=game;minecraft;launcher;mc;multimc;polymc;
  #   MimeType=application/zip;application/x-modrinth-modpack+zip
  #   Name=Prism Launcher
  #   NoDisplay=false
  #   Path=
  #   StartupNotify=true
  #   StartupWMClass=PrismLauncher
  #   Terminal=false
  #   TerminalOptions=
  #   Type=Application
  #   Version=1.0
  #   X-KDE-SubstituteUID=false
  #   X-KDE-Username=
  # '';
}
