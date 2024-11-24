{
  stdenv,
  fetchzip,
  lib,
  autoPatchelfHook,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "audiothing-noises";
  version = "1.2.1";

  src = fetchzip {
    url = "https://audiothing.nyc3.cdn.digitaloceanspaces.com/38042111/Noises-1.2.1.tar.xz";
    sha256 = "0nm51yc9j6jfk5bczjq1brwg83x07jz6jkd7dpg5ypskp68y29bp";
  };

  buildInputs = [stdenv.cc.cc.lib pkgs.libatomic_ops pkgs.alsa-lib pkgs.freetype pkgs.libGL pkgs.curl];

  nativeBuildInputs = [autoPatchelfHook];

  installPhase = ''

    runHook preInstall

    ls $src

    mkdir -p $out/lib64/vst3/audiothing
    cp -r $src/Plugins/Noises.vst3 $out/lib64/vst3/audiothing

    mkdir -p $out/lib64/vst/audiothing
    cp -r $src/Plugins/Noises.so $out/lib64/vst/audiothing

    mkdir -p $out/lib64/clap/audiothing
    cp -r $src/Plugins/Noises.clap $out/lib64/clap/audiothing

    runHook postInstall

  '';

  meta = with lib; {
    description = "audiothing things texture plugin";
    homepage = "https://audiothings.com/";
    platforms = platforms.x86_64;
  };
}
