{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  libGL,
  expat,
  xdg-utils,
  zlib-ng,
  zlib,
  fontconfig,
  libXrender,
  libXtst,
  xinput,
  alsa-lib,
  makeWrapper,
  dpkg,
}:
stdenv.mkDerivation rec {
  pname = "recstar";
  version = "1.1.2";

  src = fetchurl {
    url = "https://github.com/sdercolin/recstar/releases/download/1.1.2/recstar-1.1.2-amd64.deb";
    sha256 = "0xhx78121xkmbisvs9mpaasrpwq1lsrrn5xmik1vl6nsp6xpf7wn";
  };

  buildInputs = [ libGL expat stdenv.cc.cc.lib xdg-utils zlib-ng zlib fontconfig libXrender libXtst xinput xinput alsa-lib  makeWrapper ];

  nativeBuildInputs = [ autoPatchelfHook dpkg ];

  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out

    mkdir -p $out/bin
    ln -s $out/opt/recstar/bin/RecStar $out/bin/RecStar
  '';

  meta = with lib; {
    description = "UTAU Reclist recorder";
    license = licenses.asl20;
    mainProgram = "RecStar";
    platforms = [ "x86_64-linux" ];
  };
}
