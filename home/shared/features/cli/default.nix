{pkgs, ...}: {
  imports = [
    ./btop.nix
    ./direnv.nix
    ./git.nix
    ./helix.nix
    ./nushell.nix
  ];
  home.packages = with pkgs; [
    just
    # eza # Better ls
    ripgrep # Better grep
    fd # Better find

    # nil # Nix LSP
    # nixfmt # Nix formatter
    # nvd # Differ
    # nix-output-monitor
    # nh # Nice wrapper for NixOS and HM
  ];
}
