{ pkgs, ... }:
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
    ruff # linter / formatter
    pyrefly # type checker / lsp
  ];

  home.sessionVariables = {
    UV_PYTHON = pkgs.python3;
    UV_PYTHON_DOWNLOADS = "never";
    UV_LINK_MODE = "symlink";
  };

  home.persistence."/persist".directories = [
    ".cache/huggingface"
  ];
}
