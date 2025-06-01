{
  lib,
  python3Packages,
  fetchFromGitHub,
}:
python3Packages.buildPythonPackage rec {
  pname = "submitit";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "facebookincubator";
    repo = "submitit";
    tag = "1.5.3";
    hash = "";
  };

  doCheck = false;
  pyproject = true;

  build-system = with python3Packages; [
    setuptools
    setuptools-scm
    wheel
  ];

  dependencies = with python3Packages; [
    setuptools
    setuptools-scm
    cloudpickle
    typing-extensions
  ];

  nativeCheckInputs = [
  ];
}
