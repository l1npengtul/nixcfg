{
  lib,
  buildPythonPackage,
  fetchPypi,
  # build-system
  setuptools,
  wheel,
  cython,
  # tests
  hypothesis,
}:
buildPythonPackage rec {
  pname = "diffq";
  version = "3.3.1";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-z4Q23FnYaVNG/NOrKW3kZCXsqwDWQJbOvnn7Ueyy65M=";
  };

  doCheck = false;

  pyproject = true;
  build-system = [
    setuptools
  ];

  dependencies = [
    setuptools
    wheel
    cython
  ];

  nativeCheckInputs = [
  ];
}
