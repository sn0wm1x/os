{ pkgs, ... }:
{
  home.packages = with pkgs; [ just ];

  home.shellAliases = {
    j = "just";
  };
}
