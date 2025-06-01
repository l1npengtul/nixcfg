{
  lib,
  python3Packages,
  fetchFromGitHub,
  dora-search,
  lameenc,
  openunmix,
}:
python3Packages.buildPythonApplication rec {
  pname = "demucs";
  version = "4.0.1";

  src = fetchFromGitHub {
    owner = "facebookresearch";
    repo = "dora";
    tag = "v0.1.12";
    hash = "sha256-v18FgiBdlNSGQmCnq63wCxcO8kJCPsUt0VznUlSPyoM=";
  };

  # do not run tests
  doCheck = false;

  # specific to buildPythonPackage, see its reference
  build-system = with python3Packages; [
    setuptools
  ];

  dependencies = with python3Packages; [
    dora-search
    einops
    julius
    lameenc
    openunmix
    pyyaml
    torch
    torchaudio
    tqdm
  ];
}
