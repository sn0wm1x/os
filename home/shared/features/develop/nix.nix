{ pkgs, ... }: {
  home.packages = with pkgs; [
    nil # language server
    nixpkgs-fmt # formatter

    nurl # hash util

    # nvd # Differ
    # nix-output-monitor
    # nh # Nice wrapper for NixOS and HM
  ];
}
