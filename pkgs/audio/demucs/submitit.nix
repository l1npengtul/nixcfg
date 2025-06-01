{
  lib,
  python3Packages,
  fetchFromGitHub,
}:
python3Packages.buildPythonPackage rec {
  pname = "dora-search";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "facebookresearch";
    repo = "submitit";
    tag = "1.2.0";
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
