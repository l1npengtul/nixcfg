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
    url = "https://audiothing.nyc3.cdn.digitaloceanspaces.com/38042111/Noises-${version}.tar.xz";
    sha256 = "0hsjwdh2543743w3l7rwsyhdzzfw7sf3y2lph5qm1npf98vkgcxg";
  };

  buildInputs = [stdenv.cc.cc.lib pkgs.libatomic_ops pkgs.alsa-lib pkgs.freetype pkgs.libGL pkgs.curl];

  nativeBuildInputs = [autoPatchelfHook];

  installPhase = ''

    runHook preInstall

    ls $src/Plugins

    mkdir -p $out/lib/vst3/audiothing
    cp -r "$src/Noises ${version}/Plugins/Noises.vst3" $out/lib/vst3/audiothing

    mkdir -p $out/lib/vst/audiothing
    cp -r "$src/Noises ${version}/Plugins/Noises.so" $out/lib/vst/audiothing

    mkdir -p $out/lib/clap/audiothing
    cp -r "$src/Noises ${version}/Plugins/Noises.clap" $out/lib/clap/audiothing

    runHook postInstall

  '';

  meta = with lib; {
    description = "audiothing noises plugin";
    homepage = "https://audiothings.com/";
    platforms = platforms.x86_64;
  };
}
