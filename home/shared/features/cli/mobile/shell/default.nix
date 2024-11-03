{
  imports = [
    ../../shell/inshellisense.nix
    ../../shell/starship.nix
    ../../shell/thefuck.nix
    # TODO: FIXME: enable yazi
    # ../../shell/yazi.nix
    ./atuin.nix
    ./direnv.nix
    ./nushell.nix
    ./zoxide.nix
  ];
}
