{
  lib,
  python3Packages,
  fetchUrl,
  lame,
}:
python3Packages.buildPythonPackage rec {
  pname = "lameenc";
  version = "1.8.1";
  format = "wheel";

  src = fetchUrl {
    url = "https://files.pythonhosted.org/packages/c6/52/f5f2d979372f3718e2792e8c3390f9eb89bc836eb484c85110c3333c9813/lameenc-1.8.1-cp313-cp313t-manylinux_2_17_x86_64.manylinux2014_x86_64.manylinux_2_28_x86_64.whl";
    hash = "sha256-68dbacf39fc049dae22b08614d363d3293822d7255908b1bfe50d51c1a0fd6a1";
  };

  doCheck = false;
  build-system = [
    python3Packages.setuptools
    python3Packages.wheel
    python3Packages.setuptools-scm
  ];

  dependencies = [
    python3Packages.setuptools
    python3Packages.wheel
  ];

  nativeCheckInputs = [
    lame
  ];
}
