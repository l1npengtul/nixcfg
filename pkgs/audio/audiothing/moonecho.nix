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
}:
stdenv.mkDerivation rec {
  pname = "audiothing-moonecho";
  version = "1.0";

  dontBuild = true;
  dontConfigure = true;
  dontPatchELF = true;
  dontStrip = true;
  dontAutoPatchelf = true;

  src = fetchzip {
    url = "https://audiothing.nyc3.cdn.digitaloceanspaces.com/MoonEcho-${version}.tar.xz";
    sha256 = "0jx8lvcc1lry62fkgy498nb41i39xjffjsm4jqaa5c88z63b15m8";
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
    "$src/Plugins/MoonEcho.desktop"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/vst3/audiothing
    cp -r "$src/Plugins/MoonEcho.vst3" $out/lib/vst3/audiothing

    mkdir -p $out/lib/vst/audiothing
    cp -r "$src/Plugins/MoonEcho.so" $out/lib/vst/audiothing

    mkdir -p $out/lib/clap/audiothing
    cp -r "$src/Plugins/MoonEcho.clap" $out/lib/clap/audiothing

    mkdir -p $out/bin $out/opt/AudioThing
    install -Dm755 $src/Plugins/MoonEcho $out/bin
    ln -s $out/bin/MoonEcho $out/opt/AudioThing

    mkdir -p $out/share/pixmaps $out/opt/AudioThing
    install -Dm444 $src/Plugins/MoonEcho.png $out/share/pixmaps/MoonEcho.png
    ln -s $src/Plugins/MoonEcho.png $out/opt/AudioThing

    mkdir -p $out/opt/AudioThing/MoonEchoPresets/
    cp -r $src/Presets/MoonEcho $out/opt/AudioThing/MoonEchoPresets

    runHook postInstall
  '';

  wrapMiniBit = ''
    # make our path
    ABANDON_ALL_HOPE="$HOME/.local/share/AudioThing/Presets/MoonEcho"
    mkdir -p $ABANDON_ALL_HOPE

    # copy our presets in there
    # since we want users to overwrite default presets, we use -i "no clobber"
    cp -r -i --no-preserve=mode,ownership ${placeholder "out"}/opt/AudioThing/MoonEchoPresets/MoonEcho/ $ABANDON_ALL_HOPE
  '';

  postFixup = ''
    wrapProgram $out/bin/MoonEcho \
        --run "$wrapMiniBit" \
        --suffix LD_LIBRARY_PATH : "${lib.strings.makeLibraryPath buildInputs}"

    autoPatchelf $out/bin

    patchelf --set-rpath "${lib.strings.makeLibraryPath buildInputs}" --force-rpath $out/lib/vst3/audiothing/MoonEcho.vst3/Contents/x86_64-linux/MoonEcho.so
    patchelf --set-rpath "${lib.strings.makeLibraryPath buildInputs}" --force-rpath $out/lib/clap/audiothing/MoonEcho.clap
    patchelf --set-rpath "${lib.strings.makeLibraryPath buildInputs}" --force-rpath $out/lib/vst/audiothing/MoonEcho.so
  '';

  meta = with lib; {
    description = "audiothing MoonEcho synth plugin";
    homepage = "https://audiothing.net/";
    platforms = platforms.x86_64;
  };
}
