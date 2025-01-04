{
  stdenv,
  fetchFromGitHub,
  lib,
  cmake,
  pkg-config,
  gcc12,
  alsa-lib,
  xorg,
  freetype,
  libGLU,
  libjack2,
  ninja,
  ladspa-sdk,
  curl,
  mesa,
  webkitgtk,
  juce,
}:
stdenv.mkDerivation rec {
  pname = "socalabs-rp2a03";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "FigBug";
    repo = "RP2A03";
    rev = "383b677226a1a686599041fb5f5fcdb81c96db7a";
    hash = "";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    ninja
    juce
    gcc12
  ];

  buildInputs = [
    gcc12
    alsa-lib
    xorg.libX11
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXrandr
    xorg.xvfb
    libGLU
    libjack2
    freetype
    ladspa-sdk
    curl
    mesa
    webkitgtk
  ];

  cmakeFlags = [
    "--preset ninja-gcc"
  ];

  cmakeBuildType = "Release";

  buildPhase = ''
    cmake --build --preset ninja-gcc --config Release --parallel $NIX_BUILD_CORES
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib64/vst3 $out/lib64/vst $out/lib64/lv2

      cp -R Builds/ninja-gcc/${src.repo}_artefacts/Release/LV2/${src.repo}.lv2 $out/lib/lv2
      cp -R Builds/ninja-gcc/${src.repo}_artefacts/Release/VST/lib${src.repo}.so $out/lib/vst
      cp -R Builds/ninja-gcc/${src.repo}_artefacts/Release/VST3/${src.repo}.vst3 $out/lib/vst3

    runHook postInstall
  '';

  NIX_LDFLAGS = (
    toString [
      "-lX11"
      "-lXcomposite"
      "-lXcursor"
      "-lXinerama"
      "-lXrandr"
    ]
  );

  meta = {
    description = "Socalabs Nintendo Entertainment System RP2A03 Emulation Plugin";
    homepage = "https://socalabs.com/synths/rp2a03/";
    platforms = ["x86_64-linux"];
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [l1npengtul];
  };
}
