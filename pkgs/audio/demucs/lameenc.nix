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
    python = "cp313";
    abi = "cp313t";
    platform = "manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64";
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
