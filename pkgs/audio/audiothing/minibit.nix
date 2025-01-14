{
  stdenv,
  fetchzip,
  lib,
  autoPatchelfHook,
  copyDesktopItems,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "audiothing-minibit";
  version = "1.7";

  src = fetchzip {
    url = "https://audiothing.nyc3.cdn.digitaloceanspaces.com/miniBit-${version}.tar.xz";
    sha256 = "130x9rlmprkvfz5b653qz8bj7b8sgibaji8cc4y92qj7sp73vzd8";
  };

  buildInputs = [stdenv.cc.cc.lib pkgs.libatomic_ops pkgs.alsa-lib pkgs.freetype pkgs.libGL pkgs.curl];

  nativeBuildInputs = [autoPatchelfHook copyDesktopItems];

  desktopItems = [
    "$src/Plugins/miniBit.desktop"
  ];

  installPhase = ''

    runHook preInstall

    mkdir -p $out/lib/vst3/audiothing
    cp -r "$src/Plugins/miniBit.vst3" $out/lib/vst3/audiothing

    mkdir -p $out/lib/vst/audiothing
    cp -r "$src/Plugins/miniBit.so" $out/lib/vst/audiothing

    mkdir -p $out/lib/clap/audiothing
    cp -r "$src/Plugins/miniBit.clap" $out/lib/clap/audiothing

    mkdir -p $out/bin
    install -Dm755 $src/Plugins/miniBit $out/bin

    mkdir -p $out/share/pixmaps/
    install -Dm444 $src/Plugins/miniBit.png $out/share/pixmaps/miniBit.png

    runHook postInstall

  '';

  meta = with lib; {
    description = "audiothing miniBit synth plugin";
    homepage = "https://audiothing.net/";
    platforms = platforms.x86_64;
  };
}
