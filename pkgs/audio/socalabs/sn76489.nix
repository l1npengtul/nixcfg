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
  # Disable VST building by default, since NixOS doesn't have a VST license
  enableVST2 ? false,
}:
stdenv.mkDerivation {
  pname = "socalabs-SN76489";
  version = "1.1.0";

  src =
    (fetchFromGitHub {
      owner = "FigBug";
      repo = "SN76489";
      rev = "210e0c799727be07cb7f9559af40616e17f20302";
      hash = "sha256-6/D9QWkK7sqhUBhWs8yoP3/qRmNkt9X6GkL0jmTZECo=";
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
      name = "SN76489";
      desktopName = "Socalabs SN76489";
      comment = "Socalabs Commodore 64 SN76489 Emulation Plugin (Standalone)";
      icon = "SN76489";
      exec = "SN76489";
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
    "-DCMAKE_AR=${stdenv.cc.cc}/bin/gcc-ar"
    "-DCMAKE_RANLIB=${stdenv.cc.cc}/bin/gcc-ranlib"
    "-DCMAKE_NM=${stdenv.cc.cc}/bin/gcc-nm"
  ];

  # enable LTO flags. disable at your peril! (too long didnt run - makes the linking process take 10 years)

  patchPhase = ''
    sed -i '159i juce::juce_recommended_lto_flags' CMakeLists.txt
    substituteInPlace CMakeLists.txt \
    --replace-fail 'FORMATS Standalone VST VST3 AU LV2' 'FORMATS Standalone ${lib.optionalString enableVST2 "VST"} VST3 LV2'
  '';

  cmakeBuildType = "Release";

  strictDeps = true;

  preBuild = ''
    export HOME=$(pwd)/home
    mkdir -p $HOME
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/vst3 $out/lib/lv2 $out/bin

    ${lib.optionalString enableVST2 ''
      mkdir -p $out/lib/vst
      cp -r SN76489_artefacts/Release/VST/libSN76489.so $out/lib/vst
    ''}

    cp -r SN76489_artefacts/Release/LV2/SN76489.lv2 $out/lib/lv2
    cp -r SN76489_artefacts/Release/VST3/SN76489.vst3 $out/lib/vst3

    install -Dm755 SN76489_artefacts/Release/Standalone/SN76489 $out/bin

    install -Dm444 $src/plugin/Resources/icon.png $out/share/pixmaps/SN76489.png

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
    description = "Socalabs Commodore 64 SN76489 Emulation Plugin";
    homepage = "https://socalabs.com/synths/commodore-64-sid/";
    platforms = lib.platforms.linux;
    mainProgram = "SN76489";
    license = [lib.licenses.gpl3] ++ lib.optional enableVST2 lib.licenses.unfree;
    maintainers = with lib.maintainers; [l1npengtul];
  };
}
