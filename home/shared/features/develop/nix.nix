{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nil # language server

    nixfmt-rfc-style # formatter
    nixpkgs-lint-community # linter
    nixpkgs-hammering # fix PR
    nixpkgs-review # review PR

    nix-update # update nix packages
    nix-inspect # inspect nix expressions
    nix-output-monitor # `nom`, pretty print

    nurl # hash util

    # nvd # Differ
    # nh # Nice wrapper for NixOS and HM
  ];

  # TODO: nix-index / nix-index-database
  # https://github.com/nix-community/nix-index
}
