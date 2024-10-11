{
  stdenv,
  fetchzip,
  lib,
}:

stdenv.mkDerivation rec {
  pname = "audiothing-minibit";
  version = "1.6.5";

  src = fetchzip {
    url = "https://audiothing.nyc3.cdn.digitaloceanspaces.com/miniBit-1.6.5.tar.xz";
    sha256 = "0bqd6718909szw7ah0rnnw1qlxvmxbiwfwb6r3z5wchcjv3avi0l";
  };

  installPhase = ''

    runHook preInstall

    mkdir -p $out/lib64/vst3/audiothing
    cp -r $src/Plugins/miniBit.vst3 $out/lib64/vst3/audiothing

    mkdir -p $out/lib64/vst/audiothing
    cp -r $src/Plugins/miniBit.so $out/lib64/vst/audiothing

    mkdir -p $out/lib64/clap/audiothing
    cp -r $src/Plugins/miniBit.clap $out/lib64/clap/audiothing

    runHook postInstall

  '';

  meta = with lib; {
    description = "audiothing miniBit synth plugin";
    homepage = "https://audiothing.net/";
    platforms = platforms.x86_64;
  };
}
