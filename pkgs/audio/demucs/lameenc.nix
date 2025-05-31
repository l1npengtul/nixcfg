{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  # build-system
  setuptools,
  setuptools-scm,
  wheel,
}:
buildPythonPackage rec {
  pname = "lameenc";
  version = "1.8.1";

  src = fetchFromGitHub {
    owner = "chrisstaite";
    repo = "lameenc";
    tag = "v1.8.1";
    hash = "";
  };

  doCheck = false;

  pyproject = true;
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
  ];
}
