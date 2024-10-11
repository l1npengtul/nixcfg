{
  stdenv,
  fetchzip,
  lib,
}:

stdenv.mkDerivation rec {
  pname = "audiothing-moon-echo";
  version = "1.0";

  src = fetchzip {
    url = "https://audiothing.nyc3.cdn.digitaloceanspaces.com/MoonEcho-1.0.tar.xz";
    sha256 = "0jx8lvcc1lry62fkgy498nb41i39xjffjsm4jqaa5c88z63b15m8";
  };

  installPhase = ''

    runHook preInstall

    mkdir -p $out/lib64/vst3/audiothing
    cp -r $src/Plugins/MoonEcho.vst3 $out/lib64/vst3/audiothing

    mkdir -p $out/lib64/vst/audiothing
    cp -r $src/Plugins/MoonEcho.so $out/lib64/vst/audiothing

    mkdir -p $out/lib64/clap/audiothing
    cp -r $src/Plugins/MoonEcho.clap $out/lib64/clap/audiothing

    runHook postInstall

  '';

  meta = with lib; {
    description = "audiothing MoonEcho plugin";
    homepage = "https://audiothing.net/";
    platforms = platforms.x86_64;
  };
}
