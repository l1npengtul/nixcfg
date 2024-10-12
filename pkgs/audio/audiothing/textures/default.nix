{
  stdenv,
  fetchzip,
  lib,
}:
stdenv.mkDerivation rec {
  pname = "audiothing-things-texture";
  version = "1.1.1";

  src = fetchzip {
    url = "https://audiothing.nyc3.cdn.digitaloceanspaces.com/ThingsTexture-1.1.1.tar.xz";
    sha256 = "0nm51yc9j6jfk5bczjq1brwg83x07jz6jkd7dpg5ypskp68y29bp";
  };

  installPhase = ''

    runHook preInstall

    mkdir -p $out/lib64/vst3/audiothing
    cp -r $src/Plugins/ThingsTexture.vst3 $out/lib64/vst3/audiothing

    mkdir -p $out/lib64/vst/audiothing
    cp -r $src/Plugins/ThingsTexture.so $out/lib64/vst/audiothing

    mkdir -p $out/lib64/clap/audiothing
    cp -r $src/Plugins/ThingsTexture.clap $out/lib64/clap/audiothing

    runHook postInstall

  '';

  meta = with lib; {
    description = "audiothing things texture plugin";
    homepage = "https://audiothings.com/";
    platforms = platforms.x86_64;
  };
}
