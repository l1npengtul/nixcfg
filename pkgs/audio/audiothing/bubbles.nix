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
  pname = "audiothing-things-bubbles";
  version = "1.1";

  dontBuild = true;
  dontConfigure = true;
  dontPatchELF = true;
  dontStrip = true;
  dontAutoPatchelf = true;

  src = fetchzip {
    url = "https://audiothing.nyc3.cdn.digitaloceanspaces.com/ThingsBubbles-${version}.tar.xz";
    sha256 = "1xlfz92254ymzcwy9kywi3mkfzz43npq30n64jvycdykanf2kp1c";
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

  nativeBuildInputs = [makeWrapper autoPatchelfHook];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/vst3/audiothing
    cp -r "$src/Plugins/ThingsBubbles.vst3" $out/lib/vst3/audiothing

    mkdir -p $out/lib/vst/audiothing
    cp -r "$src/Plugins/ThingsBubbles.so" $out/lib/vst/audiothing

    mkdir -p $out/lib/clap/audiothing
    cp -r "$src/Plugins/ThingsBubbles.clap" $out/lib/clap/audiothing

    mkdir -p $out/bin $out/opt/AudioThing
    install -Dm755 $src/Plugins/ThingsBubbles $out/bin
    ln -s $out/bin/ThingsBubbles $out/opt/AudioThing

    mkdir -p $out/opt/AudioThing/ThingsBubblesPresets/
    cp -r $src/Presets/ThingsBubbles $out/opt/AudioThing/ThingsBubblesPresets

    runHook postInstall
  '';

  wrapMiniBit = ''
    # make our path
    ABANDON_ALL_HOPE="$HOME/.local/share/AudioThing/Presets/ThingsBubbles"
    mkdir -p $ABANDON_ALL_HOPE

    # copy our presets in there
    # since we want users to overwrite default presets, we use -i "no clobber"
    cp -r -i --no-preserve=mode,ownership ${placeholder "out"}/opt/AudioThing/ThingsBubblesPresets/ThingsBubbles/ $ABANDON_ALL_HOPE
  '';

  postFixup = ''
    wrapProgram $out/bin/ThingsBubbles \
        --run "$wrapMiniBit" \
        --suffix LD_LIBRARY_PATH : "${lib.strings.makeLibraryPath buildInputs}"

    autoPatchelf $out/bin

    patchelf --set-rpath "${lib.strings.makeLibraryPath buildInputs}" --force-rpath $out/lib/vst3/audiothing/ThingsBubbles.vst3/Contents/x86_64-linux/ThingsBubbles.so
    patchelf --set-rpath "${lib.strings.makeLibraryPath buildInputs}" --force-rpath $out/lib/clap/audiothing/ThingsBubbles.clap
    patchelf --set-rpath "${lib.strings.makeLibraryPath buildInputs}" --force-rpath $out/lib/vst/audiothing/ThingsBubbles.so
  '';

  meta = with lib; {
    description = "audiothing ThingsBubbles synth plugin";
    homepage = "https://audiothing.net/";
    platforms = platforms.x86_64;
  };
}
