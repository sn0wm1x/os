{ pkgs, ... }: {
  home.packages = with pkgs; [
    (python3.withPackages (python3Packages: with python3Packages; [
      pipx
      pip
    ]))
    poetry # package manager
    ruff # linter
  ];
}
