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
  juce,
  srcOnly,
  # Disable VST building by default, since NixOS doesn't have a VST license
  enableVST2 ? false,
}: let
  gin = fetchFromGitHub {
    owner = "FigBug";
    repo = "gin";
    rev = "f5c6bbcc82fd63ebc5c08f2edb20f5f3a0ba0128";
    hash = "sha256-YX/DiTWBrcn57hR1vPNajQ3TeXzvBtH622xbNN1x00U=";
  };
in
  stdenv.mkDerivation {
    pname = "socalabs-sid";
    version = "1.1.0";

    src =
      (fetchFromGitHub {
        owner = "FigBug";
        repo = "SID";
        rev = "bb826fdea39da0804c53d81d35bea29aeff4436d";
        hash = "sha256-6IStysItOS7EltTCqdyo9vrsnSA1YYoN4y8Bjv1fhNk=";
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
        name = "socalabs-sid";
        desktopName = "Socalabs SID";
        comment = "Socalabs Commodore 64 SID Emulation Plugin (Standalone)";
        icon = "SID";
        exec = "SID";
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
      juce
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

      # patch gin to latest
      rm -rf modules/gin
      ln -s ${gin} modules/gin
      # patch JUCE to latest
      rm -rf modules/juce
      ln -s ${srcOnly juce} modules/juce
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
        cp -r SID_artefacts/Release/VST/libSID.so $out/lib/vst
      ''}

      cp -r SID_artefacts/Release/LV2/SID.lv2 $out/lib/lv2
      cp -r SID_artefacts/Release/VST3/SID.vst3 $out/lib/vst3

      install -Dm755 SID_artefacts/Release/Standalone/SID $out/bin

      install -Dm444 $src/plugin/Resources/icon.png $out/share/pixmaps/SID.png

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
      description = "Socalabs Commodore 64 SID Emulation Plugin";
      homepage = "https://socalabs.com/synths/commodore-64-sid/";
      platforms = lib.platforms.linux;
      mainProgram = "SID";
      license = [lib.licenses.gpl3] ++ lib.optional enableVST2 lib.licenses.unfree;
      maintainers = with lib.maintainers; [l1npengtul];
    };
  }
