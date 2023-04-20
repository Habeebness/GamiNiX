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
    rev = "ec55880788f812c08b7991c039b6d4bada4132ab";
    sha256 = "eg3NUrpaJjq/TmSKpC5ZpIVhYIFlrNzuhvm7SF/xRAA=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkgconfig
    wrapGAppsHook
  ];
  buildInputs = [gtk3 gtk-layer-shell json_c glib libpulseaudio libmpdclient libxkbcommon];

  #mesonFlags = [ -Dbsdctl=disabled ];
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