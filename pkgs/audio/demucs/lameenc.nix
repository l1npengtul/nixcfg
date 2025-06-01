{
  lib,
  python3Packages,
  fetchFromGitHub,
  lame,
}:
python3Packages.buildPythonPackage rec {
  pname = "lameenc";
  version = "1.8.1";

  src = fetchFromGitHub {
    owner = "chrisstaite";
    repo = "lameenc";
    tag = "v1.8.1";
    hash = "sha256-/GV18mPcru1raFfFQGSAHgNwpmwN4oVFKcBL4JjZkC8=";
  };

  doCheck = false;
  pyproject = true;
  build-system = with python3Packages; [
    setuptools
    wheel
    setuptools-scm
  ];

  nativeBuildInputs = [
    lame
  ];

  dependencies = with python3Packages; [
    setuptools
    wheel
  ];

  nativeCheckInputs = [
  ];

  preBuild = ''
    substituteInPlace setup.py \
      --replace-fail 'libdir = None' 'libdir = ${lame.lib}'
  '';
}
