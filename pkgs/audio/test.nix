{
  lib,
  stdenv,
  fetchFromGitHub,
  ensureNewerSourcesForZipFilesHook,
  makeDesktopItem,
  copyDesktopItems,
  imagemagick,
  cmake,
  pkg-config,
  alsa-lib,
  freetype,
  webkitgtk_4_0,
  zenity,
  curl,
  xorg,
  python3,
  makeWrapper,
}: let
  version = "0.9.1";
in
  stdenv.mkDerivation {
    pname = "plugdata";
    inherit version;

    src = fetchFromGitHub {
      owner = "plugdata-team";
      repo = "plugdata";
      rev = "v${version}";
      hash = "";
      fetchSubmodules = true;
    };

    nativeBuildInputs = [
      cmake
      pkg-config
      ensureNewerSourcesForZipFilesHook
      copyDesktopItems
      imagemagick
      python3
      makeWrapper
    ];

    buildInputs = [
      alsa-lib
      curl
      freetype
      webkitgtk_4_0
      xorg.libX11
      xorg.libXcursor
      xorg.libXext
      xorg.libXinerama
      xorg.libXrender
      xorg.libXrandr
    ];

    desktopItems = [
      (makeDesktopItem {
        name = "PlugData";
        desktopName = "PlugData";
        exec = "plugdata";
        icon = "plugdata_logo.png";
        comment = "Pure Data as a plugin, with a new GUI";
        type = "Application";
        categories = [
          "AudioVideo"
          "Music"
        ];
      })
    ];

    NIX_LDFLAGS = (
      toString [
        "-lX11"
        "-lXext"
        "-lXcursor"
        "-lXinerama"
        "-lXrandr"
        "-lXrender"
      ]
    );

    preBuild = ''
      # fix LV2 build
      HOME=$(mktemp -d)
    '';

    installPhase = ''
      runHook preInstall

      cd .. # build artifacts are placed inside the source directory for some reason
      mkdir -p $out/{bin,lib/{clap,vst3}}
      cp    Plugins/Standalone/plugdata      $out/bin
      cp -r Plugins/CLAP/plugdata{,-fx}.clap $out/lib/clap
      cp -r Plugins/VST3/plugdata{,-fx}.vst3 $out/lib/vst3

      install -Dm444 $src/Resources/Icons/plugdata_logo_linux.png $out/share/pixmaps/plugdata_logo.png

      runHook postInstall
    '';

    postInstall = ''
      # Ensure zenity is available, or it won't be able to open new files.
      wrapProgram $out/bin/plugdata \
        --prefix PATH : '${
        lib.makeBinPath [
          zenity
        ]
      }'
    '';

    meta = with lib; {
      description = "Plugin wrapper around Pure Data to allow patching in a wide selection of DAWs";
      mainProgram = "plugdata";
      homepage = "https://plugdata.org/";
      license = licenses.gpl3;
      platforms = platforms.linux;
      maintainers = with maintainers; [PowerUser64];
    };
  }
