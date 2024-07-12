{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (python3.withPackages (
      python3Packages: with python3Packages; [
        pipx
        pip
      ]
    ))
    uv # package manager
    ruff # linter
  ];
}
