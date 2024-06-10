{ pkgs, ... }:
let
  logo = pkgs.fetchurl
    {
      url = "https://github.com/sn0wm1x.png";
      sha256 = "62s/Ok5fsL+Yr3lz4dXC/LIDsoUTXDVIzF9Cya3flxc=";
    };
in
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "${logo}";
      };
    };
  };

  home.shellAliases = {
    nf = "fastfetch";
    neofetch = "fastfetch";
  };
}
