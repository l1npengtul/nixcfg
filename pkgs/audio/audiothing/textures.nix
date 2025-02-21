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
  pname = "audiothing-things-texture";
  version = "1.1.1";

  dontBuild = true;
  dontConfigure = true;
  dontPatchELF = true;
  dontStrip = true;
  dontAutoPatchelf = true;

  src = fetchzip {
    url = "https://audiothing.nyc3.cdn.digitaloceanspaces.com/ThingsTexture-${version}.tar.xz";
    sha256 = "0nm51yc9j6jfk5bczjq1brwg83x07jz6jkd7dpg5ypskp68y29bp";
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
    "$src/Plugins/ThingsTexture.desktop"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/vst3/audiothing
    cp -r "$src/Plugins/ThingsTexture.vst3" $out/lib/vst3/audiothing

    mkdir -p $out/lib/vst/audiothing
    cp -r "$src/Plugins/ThingsTexture.so" $out/lib/vst/audiothing

    mkdir -p $out/lib/clap/audiothing
    cp -r "$src/Plugins/ThingsTexture.clap" $out/lib/clap/audiothing

    mkdir -p $out/bin $out/opt/AudioThing
    install -Dm755 $src/Plugins/ThingsTexture $out/bin
    ln -s $out/bin/ThingsTexture $out/opt/AudioThing

    mkdir -p $out/share/pixmaps $out/opt/AudioThing
    install -Dm444 $src/Plugins/ThingsTexture.png $out/share/pixmaps/ThingsTexture.png
    ln -s $src/Plugins/ThingsTexture.png $out/opt/AudioThing

    mkdir -p $out/opt/AudioThing/ThingsTexturePresets/
    cp -r $src/Presets/ThingsTexture $out/opt/AudioThing/ThingsTexturePresets

    runHook postInstall
  '';

  wrapMiniBit = ''
    # make our path
    ABANDON_ALL_HOPE="$HOME/.local/share/AudioThing/Presets/ThingsTexture"
    mkdir -p $ABANDON_ALL_HOPE

    # copy our presets in there
    # since we want users to overwrite default presets, we use -i "no clobber"
    cp -r -i --no-preserve=mode,ownership ${placeholder "out"}/opt/AudioThing/ThingsTexturePresets/ThingsTexture/ $ABANDON_ALL_HOPE
  '';

  postFixup = ''
    wrapProgram $out/bin/ThingsTexture \
        --run "$wrapMiniBit" \
        --suffix LD_LIBRARY_PATH : "${lib.strings.makeLibraryPath buildInputs}"

    autoPatchelf $out/bin

    patchelf --set-rpath "${lib.strings.makeLibraryPath buildInputs}" --force-rpath $out/lib/vst3/audiothing/ThingsTexture.vst3/Contents/x86_64-linux/ThingsTexture.so
    patchelf --set-rpath "${lib.strings.makeLibraryPath buildInputs}" --force-rpath $out/lib/clap/audiothing/ThingsTexture.clap
    patchelf --set-rpath "${lib.strings.makeLibraryPath buildInputs}" --force-rpath $out/lib/vst/audiothing/ThingsTexture.so
  '';

  meta = with lib; {
    description = "audiothing ThingsTexture synth plugin";
    homepage = "https://audiothing.net/";
    platforms = platforms.x86_64;
  };
}
