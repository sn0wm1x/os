{ lib, pkgs, ... }: {
  home.packages = with pkgs; [
    (python3.withPackages (python3Packages: with python3Packages; [
      pipx
      pip
    ]))
    poetry # package manager
    ruff # linter
  ];

  # temporary fix `libstdc++.so.6: cannot open shared object file: No such file or directory`
  home.sessionVariables = {
    LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
  };
}
