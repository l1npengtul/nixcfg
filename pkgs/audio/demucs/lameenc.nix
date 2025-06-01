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
    sha256 = "68dbacf39fc049dae22b08614d363d3293822d7255908b1bfe50d51c1a0fd6a1";
    dist = "cp313";
    python = "py3";
    platform = "manylinux_2_17_x86_64.manylinux2014_x86_64.manylinux_2_28_x86_64";
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
