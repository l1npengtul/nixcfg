{
  stdenv,
  fetchFromGitHub,
  lib,
  cmake,
  pkg-config,
  gcc12,
  alsa-lib,
  xorg,
  freetype,
  libGLU,
  libjack2,
  cpm-cmake,
}:
stdenv.mkDerivation {
  pname = "airwin2rack-juce";
  version = "2.13.0";

  src = fetchFromGitHub {
    owner = "baconpaul";
    repo = "airwin2rack";
    rev = "db56d13f853831ab94a5e1713282e4e518f50d5c";
    hash = "sha256-D+Lw+3i/ME2BPwGr2S2CwonVhe+rTiVONcz4+htj+7w=";
  };

  nativeBuildInputs = [
    cmake
    cpm-cmake
    pkg-config
    gcc12
  ];

  buildInputs = [
    gcc12
    alsa-lib
    xorg.libX11
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXext
    xorg.libXinerama
    xorg.xrandr
    xorg.libXrender
    libGLU
    libjack2
    freetype
  ];

  cmakeFlags = [
    (lib.cmakeFeature "CMAKE_BUILD_TYPE" "Release")
    (lib.cmakeBool "BUILD_JUCE_PLUGIN" true)
    (lib.cmakeBool "USE_JUCE_PROGRAMS" true)
  ];

  buildPhase = ''
    cmake --build $src/ignore/daw-plugin --target awcons-products
  '';

  installPhase = ''
    ls -l $src/build/installer
    exit 1
  '';

  meta = {
    description = "JUCE Plugin Version of Airwindows Consolidated";
    homepage = "https://airwindows.com/";
    platforms = ["x86_64-linux"];
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [l1npengtul];
  };
}
