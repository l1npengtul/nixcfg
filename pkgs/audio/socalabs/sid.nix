{
  stdenv,
  fetchFromGitHub,
  lib,
  cmake,
  pkg-config,
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
  libsysprof-capture,
  pcre2,
  gcc12,
  makeFontsCache,
}: let
  plname = "SID";
in
  stdenv.mkDerivation rec {
    pname = "socalabs-sid";
    version = "1.1.0";

    fontsConf = makeFontsCache {
      fontDirectories = [
      ];
    };

    src =
      (fetchFromGitHub
        {
          owner = "FigBug";
          repo = plname;
          rev = "bb826fdea39da0804c53d81d35bea29aeff4436d";
          hash = "sha256-6IStysItOS7EltTCqdyo9vrsnSA1YYoN4y8Bjv1fhNk=";
          fetchSubmodules = true;
        })
      .overrideAttrs (_: {
        GIT_CONFIG_COUNT = 1;
        GIT_CONFIG_KEY_0 = "url.https://github.com/.insteadOf";
        GIT_CONFIG_VALUE_0 = "git@github.com:";
      });

    nativeBuildInputs = [
      gcc12
      cmake
      pkg-config
      ninja
    ];

    buildInputs = [
      alsa-lib
      xorg.libX11
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXinerama
      xorg.libXrandr
      xorg.xvfb
      libGLU
      libjack2
      libsysprof-capture
      freetype
      ladspa-sdk
      curl
      mesa
      webkitgtk
      pcre2
    ];

    cmakeFlags = [
      (lib.cmakeBool "BUILD_EXTRAS" true)
      (lib.cmakeBool "BUILD_TESTING" true)
      (lib.cmakeBool "JUCE_COPY_PLUGIN_AFTER_BUILD" false)
      "-DCMAKE_CXX_COMPILER=g++"
      "-DCMAKE_C_COMPILER=gcc"
      "-DCMAKE_Fortran_COMPILER=gfortran"
      "--preset ninja-gcc"
    ];

    cmakeBuildType = "Release";

    strictDeps = true;

    buildPhase = ''
      #ln -s $src/CMakePresets.json /build/source/build/
      #ln -s $src/modules  /build/source/build/modules
      #ln -s /build/source/Builds /build/source/build/Builds
      cd /build/source/Builds/ninja-gcc
      export FONTCONFIG_FILE=${fontsConf}
      ninja -v -j $NIX_BUILD_CORES -f build-Release.ninja
      echo "turtle"
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/lib/vst3 $out/lib/vst $out/lib/lv2

      cp -R Builds/ninja-gcc/${plname}_artefacts/Release/LV2/${plname}.lv2 $out/lib/lv2
      cp -R Builds/ninja-gcc/${plname}_artefacts/Release/VST/lib${plname}.so $out/lib/vst
      cp -R Builds/ninja-gcc/${plname}_artefacts/Release/VST3/${plname}.vst3 $out/lib/vst3

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
      description = "Socalabs Commodore 64 SID Emulation Plugin";
      homepage = "https://socalabs.com/synths/commodore-64-sid/";
      platforms = ["x86_64-linux"];
      license = lib.licenses.gpl3;
      maintainers = with lib.maintainers; [l1npengtul];
    };
  }
