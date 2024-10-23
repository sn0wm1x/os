{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    (python3.withPackages (
      python3Packages: with python3Packages; [
        pipx
        pip
        huggingface-hub
        # TODO: check CUDA
        # torchWithCuda
        # torchvision
        # torchaudio
      ]
    ))
    uv # package manager
    ruff # linter
  ];

  home.persistence."/persist${config.home.homeDirectory}".directories = [
    ".cache/huggingface"
  ];
}
