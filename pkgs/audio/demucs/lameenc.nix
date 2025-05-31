{
  lib,
  pkgs,
  buildPythonPackage,
  fetchPypi,
  # build-system
  setuptools,
  setuptools-scm,
  wheel,
}:
buildPythonPackage rec {
  pname = "lameenc";
  version = "1.8.1";
  format = "wheel";

  src = fetchPypi {
    inherit pname version format;
    sha256 = "";
    dist = "py3";
    python = "py3";
  };

  doCheck = false;
  build-system = [
    setuptools
    wheel
    setuptools-scm
  ];

  dependencies = [
    setuptools
    wheel
  ];

  nativeCheckInputs = [
    pkgs.lame
  ];
}
