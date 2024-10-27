{
  lib,
  pkgs,
  fetchFromGitHub,
  python3Packages,
}:
python3Packages.buildPythonPackage rec {
  pname = "static-ffmpeg";
  version = "2.7";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "zackees";
    repo = "static_ffmpeg";
    rev = "20d41392a6e60468aaf4b5d8f4e4877271a9a888";
    hash = "sha256-uiejzqWFTm2wI2Cq6WcjJ/LFkMt827FAqdowFjM3WFY=";
  };

  doCheck = false;

  buildInputs = [python3Packages.setuptools python3Packages.setuptools-scm python3Packages.cython python3Packages.numpy python3Packages.matplotlib python3Packages.numba python3Packages.scipy];

  propagatedBuildInputs = [pkgs.ffmpeg_7-full];

  meta = with lib; {
    description = "The easiest way to get ffmpeg v5 installed through python.";
    mainProgram = "static_ffmpeg";
    homepage = "https://github.com/dwolfhub/zxcvbn-python";
    license = licenses.mit;
    maintainers = [];
  };
}
