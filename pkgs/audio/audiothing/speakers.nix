{
  stdenv,
  fetchzip,
  lib,
  autoPatchelfHook,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "audiothing-speakers";
  version = "1.3";

  src = fetchzip {
    url = "https://audiothing.nyc3.cdn.digitaloceanspaces.com/29921240/Speakers-${version}.tar.xz";
    sha256 = "0j5qyvyl2x5i631cgjziybm47p0p0ncpzsm39vca7v883bdrajn3";
  };

  buildInputs = [stdenv.cc.cc.lib pkgs.libatomic_ops pkgs.alsa-lib pkgs.freetype pkgs.libGL pkgs.curl];

  nativeBuildInputs = [autoPatchelfHook];

  installPhase = ''

    runHook preInstall

    mkdir -p $out/lib/vst3/audiothing
    cp -r "$src/Speakers ${version}/Plugins/Speakers.vst3" $out/lib/vst3/audiothing

    mkdir -p $out/lib/vst/audiothing
    cp -r "$src/Speakers ${version}/Plugins/Speakers.so" $out/lib/vst/audiothing

    mkdir -p $out/lib/clap/audiothing
    cp -r "$src/Speakers ${version}/Plugins/Speakers.clap" $out/lib/clap/audiothing

    runHook postInstall

  '';

  meta = with lib; {
    description = "audiothing Speakers synth plugin";
    homepage = "https://audiothing.net/";
    platforms = platforms.x86_64;
  };
}
