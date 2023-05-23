{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkgconfig,
  wrapGAppsHook,
  gtk3,
  libpulseaudio,
  libmpdclient,
  libxkbcommon,
  gtk-layer-shell,
  json_c,
  glib,
}:
stdenv.mkDerivation rec {
  pname = "sfwbar";
  version = "git";
  src = fetchFromGitHub {
    owner = "LBCrion";
    repo = pname;
    rev = "583b73e3b09d5f9b62e185106ee53eaaf7fec1e0";
    sha256 = "agu12JV2lythbADP1EO+16k3eehHlDXxmXQyCqytRkc=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkgconfig
    wrapGAppsHook
  ];

  buildInputs = [
    gtk3
    gtk-layer-shell
    json_c
    glib
    libpulseaudio
    libmpdclient
    libxkbcommon
  ];

  mesonFlags = [
    "-Dbsdctl=disabled"
  ];

  doCheck = false;

  postPatch = ''
    sed -i 's|gio/gdesktopappinfo.h|gio-unix-2.0/gio/gdesktopappinfo.h|' src/scaleimage.c
  '';

  meta = with lib; {
    description = "Sway Floating Window Bar";
    homepage = "https://github.com/LBCrion/sfwbar";
    license = licenses.lgpl21Plus;
    platforms = platforms.unix;
  };
}
