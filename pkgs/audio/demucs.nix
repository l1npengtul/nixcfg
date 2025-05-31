{
  lib,
  buildPythonApplication,
  fetchPypi,
  setuptools,
  wheel,
  dora-search,
  diffq,
  einops,
  flake8,
  hydra-colorlog,
  hydra-core,
  julius,
  lameenc,
  museval,
  mypy,
  openunmix,
  pyyaml,
  submitit,
  torch,
  torchaudio,
  tqdm,
  treetable,
  soundfile,
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
  build-system = [
    setuptools
  ];

  dependencies = [
    dora-search
    diffq
    einops
    flake8
    hydra-colorlog
    hydra-core
    julius
    lameenc
    museval
    mypy
    openunmix
    pyyaml
    submitit
    torch
    torchaudio
    tqdm
    treetable
    soundfile
  ];
}
