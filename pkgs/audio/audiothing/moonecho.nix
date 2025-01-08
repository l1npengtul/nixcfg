{
  stdenv,
  fetchzip,
  lib,
  autoPatchelfHook,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "audiothing-moonecho";
  version = "1.0";

  src = fetchzip {
    url = "https://audiothing.nyc3.cdn.digitaloceanspaces.com/MoonEcho-${version}.tar.xz";
    sha256 = "0jx8lvcc1lry62fkgy498nb41i39xjffjsm4jqaa5c88z63b15m8";
  };

  buildInputs = [stdenv.cc.cc.lib pkgs.libatomic_ops pkgs.alsa-lib pkgs.freetype pkgs.libGL pkgs.curl];

  nativeBuildInputs = [autoPatchelfHook];

  installPhase = ''

    runHook preInstall

    mkdir -p $out/lib/vst3/audiothing
    cp -r "$src/Plugins/MoonEcho.vst3" $out/lib/vst3/audiothing

    mkdir -p $out/lib/vst/audiothing
    cp -r "$src/Plugins/MoonEcho.so" $out/lib/vst/audiothing

    mkdir -p $out/lib/clap/audiothing
    cp -r "$src/Plugins/MoonEcho.clap" $out/lib/clap/audiothing

    runHook postInstall

  '';

  meta = with lib; {
    description = "audiothing MoonEcho plugin";
    homepage = "https://audiothing.net/";
    platforms = platforms.x86_64;
  };
}
