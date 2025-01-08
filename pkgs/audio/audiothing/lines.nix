{
  stdenv,
  fetchzip,
  lib,
  autoPatchelfHook,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "audiothing-lines";
  version = "1.1";

  src = fetchzip {
    url = "https://audiothing.nyc3.cdn.digitaloceanspaces.com/Lines-${version}.tar.xz";
    sha256 = "03bwdj7s7qdg11sc8gj010zlvfz4dmwwf79lxg5mfvai8sg9c95z";
  };

  buildInputs = [stdenv.cc.cc.lib pkgs.libatomic_ops pkgs.alsa-lib pkgs.freetype pkgs.libGL pkgs.curl];

  nativeBuildInputs = [autoPatchelfHook];

  installPhase = ''

    runHook preInstall

    mkdir -p $out/lib/vst3/audiothing
    cp -r "$src/Lines ${version}/Plugins/Lines.vst3" $out/lib/vst3/audiothing

    mkdir -p $out/lib/vst/audiothing
    cp -r "$src/Lines ${version}/Plugins/Lines.so" $out/lib/vst/audiothing

    mkdir -p $out/lib/clap/audiothing
    cp -r "$src/Lines ${version}/Plugins/Lines.clap" $out/lib/clap/audiothing

    runHook postInstall

  '';

  meta = with lib; {
    description = "audiothing lines plugin";
    homepage = "https://audiothings.com/";
    platforms = platforms.x86_64;
  };
}
