{ outputs, ... }:
{
  imports = [
    outputs.homeManagerModules.baseline
    outputs.homeManagerModules.nushell
  ];

  sn0wm1x.baseline.enable = true;
  sn0wm1x.nushell.enable = true;
}
