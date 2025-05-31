{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  setuptools-scm,
  wheel,
  matplotlib,
  pandas,
  numpy,
  scipy,
  scikit-learn,
}:
buildPythonPackage rec {
  pname = "dora-search";
  version = "0.1.12";

  src = fetchFromGitHub {
    owner = "facebookresearch";
    repo = "dora";
    tag = "v0.1.12";
    hash = "";
  };

  doCheck = false;

  build-system = [
    setuptools
    setuptools-scm
    wheel
  ];

  dependencies = [
    setuptools
    setuptools-scm
    matplotlib
    pandas
    numpy
    scipy
    scikit-learn
  ];

  nativeCheckInputs = [
  ];
}
