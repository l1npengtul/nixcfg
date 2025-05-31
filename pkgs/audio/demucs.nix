{
  lib,
  pkgs,
  buildPythonApplication,
  fetchPypi,
  setuptools,
  wheel,
}:
buildPythonApplication rec {
  pname = "demucs";
  version = "4.0.1";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-5FpaeIuueXZ8N7v25pquA4Yt3MoFVQ+3m5JjRqF31xM=";
  };

  # do not run tests
  doCheck = false;

  # specific to buildPythonPackage, see its reference
  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];
}
