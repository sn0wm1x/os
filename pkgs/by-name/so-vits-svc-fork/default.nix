{ config
, lib
  # , buildPythonPackage
, python3Packages
, fetchFromGitHub
  # CUDA
  # WONTFIX: Since I don't have a CUDA device, I can't test it. If you are interested in this, welcome to contact me!
, cudaSupport ? config.cudaSupport
  # ROCm
  # FIXME: Rocm support is currently broken because `rocmPackages.hipblaslt` is unpackaged. (2024-06-09)
, rocmSupport ? config.rocmSupport
}:
python3Packages.buildPythonPackage rec {
  pname = "so-vits-svc-fork";
  version = "4.2.9";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "voicepaw";
    repo = "so-vits-svc-fork";
    rev = "v${version}";
    hash = "sha256-ASqo4FBoFe2caIXfRtiVVVeBgUkNtWvb0u5Nc6KSJ3s=";
  };

  # do not run tests
  doCheck = false;

  # specific to buildPythonPackage, see its reference
  build-system = with python3Packages; [
    poetry-core
    setuptools
    wheel
  ];

  dependencies = with python3Packages; [
    (
      if cudaSupport
      then torchWithCuda
      else if rocmSupport
      then torchWithRocm
      else torch
    )
    torchaudio
  ];

  meta = {
    description = "A fork of so-vits-svc";
    homepage = "https://github.com/voicepaw/so-vits-svc-fork";
    license = lib.licenses.mit;
    mainProgram = "svc";
    maintainers = with lib.maintainers; [ kwaa ];
    platforms = lib.platforms.linux;
  };
}
