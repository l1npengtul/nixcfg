{
  stdenv,
  fetchzip,
  lib,
  alsaLib,
  freetype,
  curl,
  libGL,
  libgcc,
  autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "synth-v-studio-pro";
  version = "1.11.2b2-1";

  src = fetchzip {
    url = "https://resource.dreamtonics.com/download/English/Synthesizer%20V%20Studio%20Beta%20Version/1.11.2b2/svstudio-pro-linux64.zip";
    sha256 = "1il9gmbsg4zvbjkqi6cry4ldzpxkkgrffgz1lj07hx3l6s07igmk";
  };

  buildInputs = [ alsaLib freetype curl libGL libgcc stdenv.cc.cc.lib ];

  nativeBuildInputs = [ autoPatchelfHook ];

  installPhase = ''

    runHook preInstall

    mkdir -p $out/opt/SynthesizerVStudioPro
    mv * $out/opt/SynthesizerVStudioPro

    mkdir -p $out/bin
    ln -s $out/opt/SynthesizerVStudioPro/synthv-studio $out/bin/synthv-studio

    runHook postInstall

  '';

  meta = with lib; {
    description = "Synthesizer V Studio Pro";
    homepage = "https://dreamtonics.com/synthesizerv/";
    platforms = [ "x86_64-linux" ];
  };
}
