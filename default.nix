with import <nixpkgs> {};

stdenv.mkDerivation rec {

  name = "st-leath-dub";
  src = ./.;

  strictDeps = true;

  makeFlags = [
    "PKG_CONFIG=${stdenv.cc.targetPrefix}pkg-config"
  ];

  nativeBuildInputs = [
    pkg-config
    fontconfig
    freetype
    ncurses
  ];

  buildInputs = [
    xorg.libX11
    xorg.libXft
    harfbuzz
  ];


  preInstall = ''
    export TERMINFO=$out/share/terminfo
  '';

  installFlags = [ "PREFIX=$(out)" ];

  passthru.tests.test = nixosTests.terminal-emulators.st;
}
