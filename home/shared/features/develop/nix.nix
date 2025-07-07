{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixd # language server

    nixfmt-rfc-style # formatter
    nixpkgs-lint-community # linter
    nixpkgs-hammering # fix PR
    nixpkgs-review # review PR

    nix-update # update nix packages
    nix-inspect # inspect nix expressions
    nix-output-monitor # `nom`, pretty print

    nurl # hash util

    nvd # differ
  ];

  # TODO: nix-index / nix-index-database
  # https://github.com/nix-community/nix-index
}
