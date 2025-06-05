{ pkgs, ... }:
{
  imports = [
    ./misc
    ./bat.nix
    ./btop.nix
    ./fastfetch.nix
    ./fzf.nix
    ./git.nix
    ./helix.nix
    ./just.nix
    ./tealdeer.nix
    ./zellij.nix
  ];
  home.packages = with pkgs; [
    # eza # Better ls
    ripgrep # Better grep
    fd # Better find
    procs # Better ps
    httpie # HTTP client
  ];
}
