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
  pname = "audiothing-fog-convolver2";
  version = "2.2";

  dontBuild = true;
  dontConfigure = true;
  dontPatchELF = true;
  dontStrip = true;
  dontAutoPatchelf = true;

  src = fetchzip {
    url = "https://audiothing.nyc3.cdn.digitaloceanspaces.com/39301751/FogConvolver-${version}.tar.xz";
    sha256 = "113s0jsk6lbryndbpgby2minm2yq4220gcp7fgk7fvk6vm48hya5";
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
    "$src/Plugins/FogConvolver2.desktop"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/vst3/audiothing
    cp -r "$src/Plugins/FogConvolver2.vst3" $out/lib/vst3/audiothing

    mkdir -p $out/lib/vst/audiothing
    cp -r "$src/Plugins/FogConvolver2.so" $out/lib/vst/audiothing

    mkdir -p $out/lib/clap/audiothing
    cp -r "$src/Plugins/FogConvolver2.clap" $out/lib/clap/audiothing

    mkdir -p $out/bin $out/opt/AudioThing
    install -Dm755 $src/Plugins/FogConvolver2 $out/bin
    ln -s $out/bin/FogConvolver2 $out/opt/AudioThing

    mkdir -p $out/share/pixmaps $out/opt/AudioThing
    install -Dm444 $src/Plugins/FogConvolver2.png $out/share/pixmaps/FogConvolver2.png
    ln -s $src/Plugins/FogConvolver2.png $out/opt/AudioThing

    mkdir -p $out/opt/AudioThing/FogConvolver2Presets/
    cp -r $src/Presets/FogConvolver2 $out/opt/AudioThing/FogConvolver2Presets

    runHook postInstall
  '';

  wrapMiniBit = ''
    # make our path
    ABANDON_ALL_HOPE="$HOME/.local/share/AudioThing/Presets/FogConvolver2"
    mkdir -p $ABANDON_ALL_HOPE

    # copy our presets in there
    # since we want users to overwrite default presets, we use -i "no clobber"
    cp -r -i --no-preserve=mode,ownership ${placeholder "out"}/opt/AudioThing/FogConvolver2Presets/FogConvolver2/ $ABANDON_ALL_HOPE
  '';

  postFixup = ''
    wrapProgram $out/bin/FogConvolver2 \
        --run "$wrapMiniBit" \
        --suffix LD_LIBRARY_PATH : "${lib.strings.makeLibraryPath buildInputs}"

    autoPatchelf $out/bin

    patchelf --set-rpath "${lib.strings.makeLibraryPath buildInputs}" --force-rpath $out/lib/vst3/audiothing/FogConvolver2.vst3/Contents/x86_64-linux/FogConvolver2.so
    patchelf --set-rpath "${lib.strings.makeLibraryPath buildInputs}" --force-rpath $out/lib/clap/audiothing/FogConvolver2.clap
    patchelf --set-rpath "${lib.strings.makeLibraryPath buildInputs}" --force-rpath $out/lib/vst/audiothing/FogConvolver2.so
  '';

  meta = with lib; {
    description = "audiothing FogConvolver2 synth plugin";
    homepage = "https://audiothing.net/";
    platforms = platforms.x86_64;
  };
}
