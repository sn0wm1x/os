{
  fetchPypi,
  lib,
  python3,

}:
let
  cutlet = python3.pkgs.buildPythonPackage rec {
    pname = "cutlet";
    version = "0.4.0";

    src = fetchPypi {
      inherit pname version;
      hash = "";
    };
  };

  ffmpeg = python3.pkgs.buildPythonPackage rec {
    pname = "ffmpeg";
    version = "1.4";

    src = fetchPypi {
      inherit pname version;
      hash = "";
    };
  };

  hangul_romanize = python3.pkgs.buildPythonPackage rec {
    pname = "hangul_romanize";
    version = "0.1.0";

    src = fetchPypi {
      inherit pname version;
      hash = "";
    };
  };

  opencc = python3.pkgs.buildPythonPackage rec {
    pname = "opencc";
    version = "1.1.9";

    src = fetchPypi {
      inherit pname version;
      hash = "";
    };
  };

  pyloudnorm = python3.pkgs.buildPythonPackage rec {
    pname = "pyloudnorm";
    version = "0.1.1";

    src = fetchPypi {
      inherit pname version;
      hash = "";
    };
  };
in
python3.pkgs.buildPythonPackage rec {
  pname = "auralis";
  version = "0.2.5";

  src = fetchPypi {
    inherit pname version;
    hash = "";
  };

  # https://github.com/astramind-ai/Auralis/blob/5020c66fefd0193a3993868c75cd1935328b5149/requirements.txt
  dependencies = with python3.pkgs; [
    aiofiles
    beautifulsoup4
    cachetools
    colorama
    cutlet # local package
    ebooklib
    einops
    ffmpeg # local package
    fsspec
    hangul_romanize # local package
    # huggingface_hub
    huggingface-hub
    ipython
    librosa
    networkx
    num2words
    opencc # local package
    packaging
    pyloudnorm # local package
    pytest
    pypinyin
    safetensors
    sounddevice
    soundfile
    spacy
    setuptools
    safetensors
    torchaudio
    tokenizers
    transformers
    vllm
    nvidia-ml-py
    numpy
  ];

  meta = {
    description = "faster implementation for TTS models, to be used in highly async environment";
    homepage = "https://github.com/astramind-ai/Auralis";
    license = lib.licenses.asl20;
    platforms = lib.platforms.linux;
    mainProgram = "auralis";
    maintainers = with lib.maintainers; [ kwaa ];
    broken = true; # WIP
  };
}
