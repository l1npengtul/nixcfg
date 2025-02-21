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
  pname = "audiothing-speakers";
  version = "1.3";

  dontBuild = true;
  dontConfigure = true;
  dontPatchELF = true;
  dontStrip = true;
  dontAutoPatchelf = true;

  src = fetchzip {
    url = "https://audiothing.nyc3.cdn.digitaloceanspaces.com/29921240/Speakers-${version}.tar.xz";
    sha256 = "0j5qyvyl2x5i631cgjziybm47p0p0ncpzsm39vca7v883bdrajn3";
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
    "$src/Plugins/Speakers.desktop"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/vst3/audiothing
    cp -r "$src/Plugins/Speakers.vst3" $out/lib/vst3/audiothing

    mkdir -p $out/lib/vst/audiothing
    cp -r "$src/Plugins/Speakers.so" $out/lib/vst/audiothing

    mkdir -p $out/lib/clap/audiothing
    cp -r "$src/Plugins/Speakers.clap" $out/lib/clap/audiothing

    mkdir -p $out/bin $out/opt/AudioThing
    install -Dm755 $src/Plugins/Speakers $out/bin
    ln -s $out/bin/Speakers $out/opt/AudioThing

    mkdir -p $out/share/pixmaps $out/opt/AudioThing
    install -Dm444 $src/Plugins/Speakers.png $out/share/pixmaps/Speakers.png
    ln -s $src/Plugins/Speakers.png $out/opt/AudioThing

    mkdir -p $out/opt/AudioThing/SpeakersPresets/
    cp -r $src/Presets/Speakers $out/opt/AudioThing/SpeakersPresets

    runHook postInstall
  '';

  wrapMiniBit = ''
    # make our path
    ABANDON_ALL_HOPE="$HOME/.local/share/AudioThing/Presets/Speakers"
    mkdir -p $ABANDON_ALL_HOPE

    # copy our presets in there
    # since we want users to overwrite default presets, we use -i "no clobber"
    cp -r -i --no-preserve=mode,ownership ${placeholder "out"}/opt/AudioThing/SpeakersPresets/Speakers/ $ABANDON_ALL_HOPE
  '';

  postFixup = ''
    wrapProgram $out/bin/Speakers \
        --run "$wrapMiniBit" \
        --suffix LD_LIBRARY_PATH : "${lib.strings.makeLibraryPath buildInputs}"

    autoPatchelf $out/bin

    patchelf --set-rpath "${lib.strings.makeLibraryPath buildInputs}" --force-rpath $out/lib/vst3/audiothing/Speakers.vst3/Contents/x86_64-linux/Speakers.so
    patchelf --set-rpath "${lib.strings.makeLibraryPath buildInputs}" --force-rpath $out/lib/clap/audiothing/Speakers.clap
    patchelf --set-rpath "${lib.strings.makeLibraryPath buildInputs}" --force-rpath $out/lib/vst/audiothing/Speakers.so
  '';

  meta = with lib; {
    description = "audiothing Speakers synth plugin";
    homepage = "https://audiothing.net/";
    platforms = platforms.x86_64;
  };
}
