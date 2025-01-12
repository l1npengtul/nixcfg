{
  clangStdenv,
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
  # Disable VST building by default, since NixOS doesn't have a VST license
  enableVST2 ? false,
}: let
  src =
    (fetchFromGitHub {
      owner = "FigBug";
      repo = "slPlugins";
      rev = "fcaec26cdd8391e19bcf1d9b21ab1e2c31d587ed";
      hash = "sha256-886+Nnemph0ux5ibjEvZvZIKGvhdn90MAHRe9TWRJag=";
      fetchSubmodules = true;
    })
    .overrideAttrs
    (_: {
      GIT_CONFIG_COUNT = 1;
      GIT_CONFIG_KEY_0 = "url.https://github.com/.insteadOf";
      GIT_CONFIG_VALUE_0 = "git@github.com:";
    });
  # This repository contains multiple plugins.
  plugins = [
    "ABTester"
    "AddInvert"
    "ChannelMute"
    "CompensatedDelay"
    "Compressor"
    "Delay"
    "Expander"
    "Gate"
    "HugeGain"
    "Limiter"
    "Maths"
    "Oscilloscope"
    "PitchTrack"
    "SFX8"
    "SampleDelay"
    "SpectrumAnalyzer"
    "ToneGenerator"
  ];
in
  clangStdenv.mkDerivation {
    pname = "socalabs-slplugins";
    version = "1.1.0";

    inherit src;

    desktopItems = [
      (
        builtins.map
        (
          plugin:
            makeDesktopItem {
              type = "Application";
              name = "socalabs-sid";
              desktopName = "Socalabs ${plugin}";
              comment = "Socalabs ${plugin} Plugin from slPlugins (Standalone)";
              exec = "${plugin}";
              categories = [
                "Audio"
                "AudioVideo"
              ];
            }
            # SFX8 (and only SFX8) contains an icon
            # We could probably make it cleaner by checking if logo.png exists,
            # but we can't automatically update this anyway due to a lack of tags,
            # and I highly doubt Socalabs will create new plugins in slPlugins
            # with new icons.
            // lib.optionalAttrs (plugin == "SFX8") {
              icon = "SFX8";
            }
        )
        plugins
      )
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
      (lib.cmakeBool "BUILD_EXTRAS" false)
      "--preset ninja-clang"
    ];

    patchPhase = ''

      # This one has all the formats in an individual CMakeLists.txt

      ${
        lib.concatMapStringsSep "\n" (
          plugin: ''
            substituteInPlace plugins/${plugin}/CMakeLists.txt --replace-fail "juce::juce_recommended_lto_flags" ""
            substituteInPlace plugins/${plugin}/CMakeLists.txt --replace-fail ""AU"" ""
            ${lib.optionalString (!enableVST2) ''
              substituteInPlace plugins/${plugin}/CMakeLists.txt --replace-fail ""VST"" ""
            ''}
          ''
        )
        plugins
      }

      # we need to patch JUCE itself to enable jack MIDI support
      # please https://github.com/juce-framework/JUCE/issues/952
      # TODO: remove when juce updates :D
      substituteInPlace modules/juce/modules/juce_audio_devices/native/juce_Midi_linux.cpp \
      --replace-fail "port = client.createPort (portName, forInput, false);" "port = client.createPort (portName, forInput, true);"
    '';

    cmakeBuildType = "Release";

    strictDeps = true;

    preBuild = ''
      # build takes 10 years without this set
      HOME=(mktemp -d)

      cd ../Builds/ninja-clang
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/lib/vst3 $out/lib/lv2 $out/bin
      ${lib.optionalString enableVST2 ''
        mkdir -p $out/lib/vst
      ''}

      ${
        (
          lib.concatMapStringsSep "\n" (
            plugin: ''
              cp -r ${plugin}_artefacts/Release/LV2/${plugin}.lv2 $out/lib/lv2
              cp -r ${plugin}_artefacts/Release/VST3/${plugin}.vst3 $out/lib/vst3
              install -Dm755 ${plugin}_artefacts/Release/Standalone/${plugin} $out/bin
              ${
                lib.optionalString enableVST2 ''
                  cp -r ${plugin}_artefacts/Release/VST3/lib${plugin}.so $out/lib/vst
                ''
              }
            ''
          )
          plugins
        )
      }

      install -Dm444 $src/plugins/SFX8/Resources/logo.png $out/share/pixmaps/SFX8.png

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
      description = "Various Socalabs Plugins";
      homepage = "https://socalabs.com";
      platforms = lib.platforms.linux;
      license = [lib.licenses.bsd3] ++ lib.optional enableVST2 lib.licenses.unfree;
      maintainers = [lib.maintainers.l1npengtul];
    };
  }
