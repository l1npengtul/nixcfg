{
  stdenv,
  fetchzip,
  lib,
  autoPatchelfHook,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "audiothing-fogconvolver";
  version = "2.2";

  src = fetchzip {
    url = "https://audiothing.nyc3.cdn.digitaloceanspaces.com/39301751/FogConvolver-${version}.tar.xz";
    sha256 = "113s0jsk6lbryndbpgby2minm2yq4220gcp7fgk7fvk6vm48hya5";
  };

  buildInputs = [stdenv.cc.cc.lib pkgs.libatomic_ops pkgs.alsa-lib pkgs.freetype pkgs.libGL pkgs.curl];

  nativeBuildInputs = [autoPatchelfHook];

  installPhase = ''

    runHook preInstall

    mkdir -p $out/lib/vst3/audiothing
    cp -r $src/Plugins/FogConvolver.vst3 $out/lib/vst3/audiothing

    mkdir -p $out/lib/vst/audiothing
    cp -r $src/Plugins/FogConvolver.so $out/lib/vst/audiothing

    mkdir -p $out/lib/clap/audiothing
    cp -r $src/Plugins/FogConvolver.clap $out/lib/clap/audiothing

    runHook postInstall

  '';

  meta = with lib; {
    description = "audiothing FogConvolver synth plugin";
    homepage = "https://audiothing.net/";
    platforms = platforms.x86_64;
  };
}
