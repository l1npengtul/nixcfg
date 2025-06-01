{
  lib,
  python3Packages,
  fetchFromGitHub,
}:
python3Packages.buildPythonPackage rec {
  pname = "treetable";
  version = "0.2.5";

  src = fetchFromGitHub {
    owner = "adefossez";
    repo = "treetable";
    rev = "8ea894b7488d751cd597aff03c1fe60c5eb1c7ff";
    hash = "";
  };

  doCheck = false;

  build-system = with python3Packages; [
    setuptools
    setuptools-scm
    wheel
  ];

  dependencies = with python3Packages; [
    setuptools
    setuptools-scm
  ];

  nativeCheckInputs = [
  ];
}
