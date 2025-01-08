{
  stdenv,
  fetchzip,
  lib,
  autoPatchelfHook,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "audiothing-things-texture";
  version = "1.1.1";

  src = fetchzip {
    url = "https://audiothing.nyc3.cdn.digitaloceanspaces.com/ThingsTexture-${version}.tar.xz";
    sha256 = "0nm51yc9j6jfk5bczjq1brwg83x07jz6jkd7dpg5ypskp68y29bp";
  };

  buildInputs = [stdenv.cc.cc.lib pkgs.libatomic_ops pkgs.alsa-lib pkgs.freetype pkgs.libGL pkgs.curl];

  nativeBuildInputs = [autoPatchelfHook];

  installPhase = ''

    runHook preInstall

    mkdir -p $out/lib/vst3/audiothing
    cp -r "$src/Plugins/ThingsTexture.vst3" $out/lib/vst3/audiothing

    mkdir -p $out/lib/vst/audiothing
    cp -r "$src/Plugins/ThingsTexture.so" $out/lib/vst/audiothing

    mkdir -p $out/lib/clap/audiothing
    cp -r "$src/Plugins/ThingsTexture.clap" $out/lib/clap/audiothing

    runHook postInstall

  '';

  meta = with lib; {
    description = "audiothing things texture plugin";
    homepage = "https://audiothings.com/";
    platforms = platforms.x86_64;
  };
}
