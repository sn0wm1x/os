{ pkgs, ... }: {
  imports = [
    ./shell
    ./bat.nix
    ./btop.nix
    ./direnv.nix
    ./fastfetch.nix
    ./fzf.nix
    ./git.nix
    ./helix.nix
    ./just.nix
    ./zellij.nix
  ];
  home.packages = with pkgs; [
    # eza # Better ls
    ripgrep # Better grep
    fd # Better find
  ];
}
