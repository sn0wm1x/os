{ pkgs, ... }:
{
  imports = [
    ../bat.nix
    ../btop.nix
    ../fastfetch.nix
    ../fzf.nix
    ../git.nix
    ../helix.nix
    ../just.nix
    ../zellij.nix
    ./shell
  ];
  home.packages = with pkgs; [
    # eza # Better ls
    ripgrep # Better grep
    fd # Better find
  ];
}
