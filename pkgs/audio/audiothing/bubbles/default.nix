{
  stdenv,
  fetchzip,
  lib,
}:

stdenv.mkDerivation {
  pname = "audiothing-things-bubbles";
  version = "1.1";

  src = fetchzip {
    url = "https://audiothing.nyc3.cdn.digitaloceanspaces.com/ThingsBubbles-1.1.tar.xz";
    sha256 = "1xlfz92254ymzcwy9kywi3mkfzz43npq30n64jvycdykanf2kp1c";
  };

  installPhase = ''

    runHook preInstall

    mkdir -p $out/lib64/vst3/audiothing
    cp -r $src/Plugins/ThingsBubbles.vst3 $out/lib64/vst3/audiothing

    mkdir -p $out/lib64/vst/audiothing
    cp -r $src/Plugins/ThingsBubbles.so $out/lib64/vst/audiothing

    mkdir -p $out/lib64/clap/audiothing
    cp -r $src/Plugins/ThingsBubbles.clap $out/lib64/clap/audiothing

    runHook postInstall

  '';

  meta = with lib; {
    description = "audiothing things bubbles plugin";
    homepage = "https://audiothings.com/";
    platforms = platforms.x86_64;
  };
}
