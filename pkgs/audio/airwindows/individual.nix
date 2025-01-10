{
  stdenv,
  fetchFromGitHub,
  fetchzip,
  lib,
  cmake,
  pkg-config,
}: let
  # the project expects a CMakeLists.txt to exist within the VSTSDK directory, but ours doesn't.cmakelist
  # Instead, we make our own.
  # adapted from oxefmsynth
  vst-sdk = let
    cmakelist = builtins.toFile "CMakeLists.txt" ''
      cmake_minimum_required(VERSION 3.9)
      project (VST_SDK)

      set(SDKSOURCES
        ''${CMAKE_CURRENT_SOURCE_DIR}/aeffeditor.h
        ''${CMAKE_CURRENT_SOURCE_DIR}/audioeffect.cpp
        ''${CMAKE_CURRENT_SOURCE_DIR}/audioeffect.h
        ''${CMAKE_CURRENT_SOURCE_DIR}/audioeffectx.cpp
        ''${CMAKE_CURRENT_SOURCE_DIR}/audioeffectx.h
        ''${CMAKE_CURRENT_SOURCE_DIR}/vstplugmain.cpp
      )

      set(PLUGINTERFACES
        ''${CMAKE_CURRENT_SOURCE_DIR}/pluginterfaces/vst2.x/aeffect.h
        ''${CMAKE_CURRENT_SOURCE_DIR}/pluginterfaces/vst2.x/aeffectx.h
        ''${CMAKE_CURRENT_SOURCE_DIR}/pluginterfaces/vst2.x/vstfxstore.h
      )

      add_library(VST_SDK STATIC ''${SDKSOURCES} ''${PLUGINTERFACES})

      set_property(TARGET VST_SDK PROPERTY POSITION_INDEPENDENT_CODE ON)

      source_group("sdk" FILES ''${SDKSOURCES})
      source_group("base" FILES ''${PLUGINTERFACES})
    '';
  in
    stdenv.mkDerivation {
      name = "vstsdk3610_11_06_2018_build_37";
      src = fetchzip {
        url = "https://web.archive.org/web/20181016150224if_/https://download.steinberg.net/sdk_downloads/vstsdk3610_11_06_2018_build_37.zip";
        sha256 = "0da16iwac590wphz2sm5afrfj42jrsnkr1bxcy93lj7a369ildkj";
      };

      installPhase = ''
        mkdir -p $out/pluginterfaces/vst2.x
        cp VST2_SDK/pluginterfaces/vst2.x/* $out/pluginterfaces/vst2.x
        cp VST2_SDK/public.sdk/source/vst2.x/* $out
        cp ${cmakelist} $out/CMakeLists.txt
      '';
    };
in
  stdenv.mkDerivation {
    pname = "airwindows";
    version = "0-unstable-2025-01-06";

    src = fetchFromGitHub {
      owner = "airwindows";
      repo = "airwindows";
      rev = "0ca33035253b9fc0c6c876592d9e5ff3a654cd10";
      hash = "sha256-+AyB6y179BRWTvflA9Ld5utpF2scSJDszkGa8BCvPdM=";
    };

    # we patch helpers because honestly im spooked out by where those variables
    # came from.
    prePatch = ''
      mkdir -p plugins/LinuxVST/include
      ln -s ${vst-sdk.out} plugins/LinuxVST/include/vstsdk
      substituteInPlace plugins/LinuxVST/Helpers.cmake \
        --replace-fail \''${VSTSDK_SOURCES} ${vst-sdk.out}/pluginterfaces/vst2.x/
      substituteInPlace plugins/LinuxVST/Helpers.cmake \
      --replace-fail \''${VSTSDK_ROOT} ${vst-sdk.out}
    '';

    # we are building for linux, so we go to linux
    preConfigure = ''
      cd plugins/LinuxVST
    '';

    cmakeBuildType = "Release";

    cmakeFlags = [];

    nativeBuildInputs = [
      cmake
      pkg-config
    ];

    buildInputs = [
      vst-sdk
    ];

    installPhase = ''
      mkdir -p $out/lib/vst/airwindows

      find "$PWD" -type f -name "*.so" -exec install -Dm755 {} $out/lib/vst/airwindows \;
    '';

    meta = {
      description = "All Airwindows VST Plugins";
      homepage = "https://airwindows.com/";
      platforms = lib.platforms.linux;
      license = [
        lib.licenses.mit
        lib.licenses.unfree
      ];
      maintainers = [lib.maintainers.l1npengtul];
    };
  }
