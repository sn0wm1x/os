{ inputs, lib, ... }:
{
  imports = [ inputs.catppuccin.homeModules.catppuccin ];

  home.activation.fixGpgHomePermissions = lib.hm.dag.entryBetween [ "linkGeneration" ] [ "createGpgHomedir" ] ''
    run chmod 700 "$HOME/.gnupg"
  '';
}
