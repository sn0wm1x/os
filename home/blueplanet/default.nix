{ outputs, ... }:
{
  imports = [
    outputs.homeManagerModules.baseline
    outputs.homeManagerModules.impermanence
    outputs.homeManagerModules.nushell
  ];

  sn0wm1x.baseline.enable = true;
  sn0wm1x.nushell.enable = true;

  # python
  home.sessionPath = [ "$HOME/.local/bin" ];
}
