{ pkgs, ... }:
{
  home.packages = with pkgs; [ onefetch ];

  home.shellAliases = {
    of = "onefetch";
  };
}
