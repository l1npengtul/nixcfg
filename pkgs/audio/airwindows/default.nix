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
}: let
  juce = fetchFromGitHub {
    owner = "juce-framework";
    repo = "JUCE";
    rev = "51d11a2be6d5c97ccf12b4e5e827006e19f0555a";
    hash = "sha256-iAueT+yHwUUHOzqfK5zXEZQ0GgOKJ9q9TyRrVfWdewc=";
    fetchSubmodules = true;
  };
  clap = fetchFromGitHub {
    owner = "free-audio";
    repo = "clap-juce-extensions";
    rev = "4f33b4930b6af806018c009f0f24b3a50808af99";
    hash = "sha256-M+T7ll3Ap6VIP5ub+kfEKwT2RW2IxxY4wUPRQKFIotk=";
    fetchSubmodules = true;
  };
in
  stdenv.mkDerivation {
    pname = "airwin2rack-juce";
    version = "2.13.0";

    src = fetchFromGitHub {
      owner = "baconpaul";
      repo = "airwin2rack";
      rev = "db56d13f853831ab94a5e1713282e4e518f50d5c";
      hash = "sha256-utqDmQgnYUtUv0E0xhO5rGx+9RXTAn8kKhTzkyXjcbE=";
      fetchSubmodules = true;
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
      xorg.libXrandr
      xorg.libXrender
      libGLU
      libjack2
      freetype
    ];

    cmakeFlags = [
      (lib.cmakeBool "BUILD_JUCE_PLUGIN" true)
      (lib.cmakeBool "USE_JUCE_PROGRAMS" true)
      "-DJUCE_DIR=${juce}"
      "-DCLAP_DIR=${clap}"
    ];

    cmakeBuildType = "Release";

    patches = [
      ./0000-juce-clap-juce-extensions-src-juce-cmakelists.patch
    ];

    preConfigure = ''
      ls -l ${clap}
      ls -l ${juce}
      ls -l .
      ls -l $src
      echo $src
      echo $pwd
    '';

    buildPhase = ''
      cmake --build $src/ignore/daw-plugin --target awcons-products
    '';

    installPhase = ''
      ls -l $src/build/installer
      exit 1
    '';

    NIX_LDFLAGS = (
      toString [
        "-lX11"
        "-lXext"
        "-lXcursor"
        "-lXinerama"
        "-lXrandr"
      ]
    );

    meta = {
      description = "JUCE Plugin Version of Airwindows Consolidated";
      homepage = "https://airwindows.com/";
      platforms = ["x86_64-linux"];
      license = lib.licenses.mit;
      maintainers = with lib.maintainers; [l1npengtul];
    };
  }
