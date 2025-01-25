{
  stdenv,
  fetchFromGitHub,
  lib,
  cmake,
  pkg-config,
  alsa-lib,
  copyDesktopItems,
  makeDesktopItem,
  xorg,
  freetype,
  expat,
  libGL,
  libjack2,
  curl,
  webkitgtk_4_0,
  libsysprof-capture,
  pcre2,
  util-linux,
  libselinux,
  libsepol,
  libthai,
  libxkbcommon,
  libdatrie,
  libepoxy,
  libsoup_2_4,
  lerc,
  sqlite,
  ninja,
  setbfree,
  # Disable VST building by default, since NixOS doesn't have a VST license
  enableVST2 ? false,
}:
stdenv.mkDerivation {
  pname = "socalabs-organ";
  version = "1.0.1";

  src =
    (fetchFromGitHub {
      owner = "FigBug";
      repo = "Organ";
      rev = "17f884126bb76d2d3c95e12224aab8f38ef8c96d";
      hash = "";
      fetchSubmodules = true;
    })
    .overrideAttrs
    (_: {
      GIT_CONFIG_COUNT = 1;
      GIT_CONFIG_KEY_0 = "url.https://github.com/.insteadOf";
      GIT_CONFIG_VALUE_0 = "git@github.com:";
    });

  desktopItems = [
    (makeDesktopItem {
      type = "Application";
      name = "socalabs-organ";
      desktopName = "Socalabs Organ";
      comment = "Socalabs Organ Plugin based on setBFree (Standalone)";
      exec = "Organ";
      categories = [
        "Audio"
        "AudioVideo"
      ];
    })
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
    copyDesktopItems
    ninja
  ];

  buildInputs = [
    alsa-lib
    xorg.libX11
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXrandr
    xorg.libXtst
    xorg.libXdmcp
    xorg.xvfb
    libGL
    libjack2
    libsysprof-capture
    libselinux
    libsepol
    libthai
    libxkbcommon
    libdatrie
    libepoxy
    libsoup_2_4
    lerc
    freetype
    curl
    webkitgtk_4_0
    pcre2
    util-linux
    sqlite
    expat
  ];

  cmakeFlags = [
    (lib.cmakeBool "JUCE_COPY_PLUGIN_AFTER_BUILD" false)
    (lib.cmakeBool "BUILD_EXTRAS" true)
    (lib.cmakeBool "BUILD_TESTING" true)
    "--preset ninja-gcc"
  ];

  patchPhase = ''
    substituteInPlace CMakeLists.txt \
    --replace-fail 'FORMATS Standalone VST VST3 AU LV2' 'FORMATS Standalone ${lib.optionalString enableVST2 "VST"} VST3 LV2'

    # we need to patch JUCE itself to enable jack MIDI support
    # please https://github.com/juce-framework/JUCE/issues/952
    # TODO: remove when juce updates :D
    substituteInPlace modules/juce/modules/juce_audio_devices/native/juce_Midi_linux.cpp \
    --replace-fail "port = client.createPort (portName, forInput, false);" "port = client.createPort (portName, forInput, true);"

    # update the vendored version of setBFree in this package
    rm -r plugin/setBFree
    ln -s ${setbfree.src} plugin/setBFree
  '';

  cmakeBuildType = "Release";

  strictDeps = true;

  preBuild = ''
    # build takes 10 years without this set
    HOME=(mktemp -d)

    cd ../Builds/ninja-gcc
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/vst3 $out/lib/lv2 $out/bin

    ${lib.optionalString enableVST2 ''
      mkdir -p $out/lib/vst
      cp -r Organ_artefacts/Release/VST/libOrgan.so $out/lib/vst
    ''}

    cp -r Organ_artefacts/Release/LV2/Organ.lv2 $out/lib/lv2
    cp -r Organ_artefacts/Release/VST3/Organ.vst3 $out/lib/vst3

    install -Dm755 Organ_artefacts/Release/Standalone/Organ $out/bin

    runHook postInstall
  '';

  NIX_LDFLAGS = (
    toString [
      "-lX11"
      "-lXext"
      "-lXcomposite"
      "-lXcursor"
      "-lXinerama"
      "-lXrandr"
      "-lXtst"
      "-lXdmcp"
    ]
  );

  meta = {
    description = "Socalabs Organ Plugin based on setBFree";
    homepage = "https://socalabs.com/synths/organ/";
    mainProgram = "Organ";
    platforms = lib.platforms.linux;
    license = [lib.licenses.gpl3] ++ lib.optional enableVST2 lib.licenses.unfree;
    maintainers = [lib.maintainers.l1npengtul];
  };
}
