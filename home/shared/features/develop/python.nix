{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    (python3.withPackages (
      python3Packages: with python3Packages; [
        pipx
        pip
        huggingface-hub
        # TODO: hf-transfer
        # TODO: check CUDA
        # torchWithCuda
        # torchvision
        # torchaudio
      ]
    ))
    uv # package manager
    ruff # linter / formatter
    ty # type checker / lsp
  ];

  home.persistence."/persist${config.home.homeDirectory}".directories = [
    ".cache/huggingface"
  ];
}
