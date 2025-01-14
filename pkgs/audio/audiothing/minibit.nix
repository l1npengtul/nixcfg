{
  stdenv,
  fetchzip,
  lib,
  autoPatchelfHook,
  #wrapGAppsHook3,
  copyDesktopItems,
  makeWrapper,
  libatomic_ops,
  alsa-lib,
  freetype,
  libjack2,
  libGL,
  curlWithGnuTls,
  #xdg-utils,
  xorg,
  fontconfig,
  writeScript,
}: let
  setup = writeScript "setup" ''
    # make our path
    ABANDON_ALL_HOPE="$HOME/.local/share/AudioThing/Presets/miniBit"
    mkdir -p $ABANDON_ALL_HOPE

    # copy our presets in there
    # since we want users to overwrite default presets, we use -i "no clobber"
    cp -r -i $out/opt/AudioThing/miniBitPresets/* $ABANDON_ALL_HOPE
  '';
in
  stdenv.mkDerivation rec {
    pname = "audiothing-minibit";
    version = "1.7";

    dontWrapGApps = true;
    dontBuild = true;
    dontConfigure = true;
    dontPatch = true;

    src = fetchzip {
      url = "https://audiothing.nyc3.cdn.digitaloceanspaces.com/miniBit-${version}.tar.xz";
      sha256 = "130x9rlmprkvfz5b653qz8bj7b8sgibaji8cc4y92qj7sp73vzd8";
    };

    buildInputs = [
      libatomic_ops
      alsa-lib
      freetype
      fontconfig
      libjack2
      libGL
      curlWithGnuTls
      xorg.libX11
      xorg.libXcursor
      xorg.libXext
      xorg.libXinerama
      xorg.libXrender
      xorg.libXrandr
      xorg.libXdmcp
      xorg.libXtst
      stdenv.cc.cc.lib
    ];

    nativeBuildInputs = [makeWrapper autoPatchelfHook copyDesktopItems];

    desktopItems = [
      "$src/Plugins/miniBit.desktop"
    ];

    installPhase = ''

      runHook preInstall

      mkdir -p $out/lib/vst3/audiothing
      cp -r "$src/Plugins/miniBit.vst3" $out/lib/vst3/audiothing

      mkdir -p $out/lib/vst/audiothing
      cp -r "$src/Plugins/miniBit.so" $out/lib/vst/audiothing

      mkdir -p $out/lib/clap/audiothing
      cp -r "$src/Plugins/miniBit.clap" $out/lib/clap/audiothing

      mkdir -p $out/bin $out/opt/AudioThing
      install -Dm755 $src/Plugins/miniBit $out/bin
      ln -s $out/bin/miniBit $out/opt/AudioThing

      mkdir -p $out/share/pixmaps $out/opt/AudioThing
      install -Dm444 $src/Plugins/miniBit.png $out/share/pixmaps/miniBit.png
      ln -s $src/Plugins/miniBit.png $out/opt/AudioThing

      mkdir -p $out/opt/AudioThing/miniBitPresets/
      cp -r $src/Presets/* $out/opt/AudioThing/miniBitPresets

      runHook postInstall
    '';

    postFixup = ''
      wrapProgram $out/bin/miniBit \
          --run "${setup}" \
          --suffix LD_LIBRARY_PATH : "${lib.strings.makeLibraryPath buildInputs}"
    '';

    meta = with lib; {
      description = "audiothing miniBit synth plugin";
      homepage = "https://audiothing.net/";
      platforms = platforms.x86_64;
    };
  }
