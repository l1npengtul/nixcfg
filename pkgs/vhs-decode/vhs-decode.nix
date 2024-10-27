{
  stdenv,
  lib,
  pipx,
  pkgs,
  fetchFromGitHub,
  python3Packages,
  static-ffmpeg,
}:
python3Packages.buildPythonPackage rec {
  pname = "vhs-decode";
  version = "0.3.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "oyvindln";
    repo = "vhs-decode";
    rev = "1ba1dca77a43f59b13cd95c6ee46ea9594a006fd";
    hash = "sha256-/ds03W4v1YyGTwWRAW4BMoh5aivHO07cB+KbxqF4HW4=";
  };

  doCheck = false;

  nativeBuildInputs = [pkgs.cmake pkgs.libsForQt5.wrapQtAppsHook pkgs.pkgconf];

  buildInputs = [pipx pkgs.libsForQt5.qt5.qtbase pkgs.libsForQt5.qwt pkgs.fftw pkgs.pkg-config pkgs.cmake pkgs.xorg.libxcb pkgs.ocl-icd pkgs.mono5 python3Packages.setuptools python3Packages.setuptools-scm python3Packages.cython python3Packages.numpy python3Packages.matplotlib python3Packages.numba python3Packages.scipy];

  propagatedBuildInputs = [static-ffmpeg pkgs.ffmpeg_7-full pkgs.pv pkgs.sox pkgs.flac python3Packages.setuptools python3Packages.samplerate python3Packages.soundfile python3Packages.sounddevice];

  preBuild = ''
    cmake .. -DCMAKE_BUILD_TYPE=Release -DUSE_QT_VERSION=5
    make -j$NIX_BUILD_CORES
    pwd
    mkdir -p $out/src
    cp -r $src/* $out/src
    chmod -R 755 $out/src
    cd $out/src
    ls $out/src
  '';

  preInstall = ''
    cd /build/source/build
    make install
    echo "aaa"
    cd $src
  '';

  meta = with lib; {
    description = "VHS Decode and Utilities";
    homepage = "https://github.com/oyvindln/vhs-decode";
    platforms = ["x86_64-linux"];
  };
}
