{ pkgs, ... }:
let
  logo = pkgs.fetchurl {
    url = "https://github.com/sn0wm1x.png";
    hash = "sha256-7gAf++UN5o7+aP8jLno46zaEtni7vwNBrxD1pDkcA3A=";
  };
  json = builtins.fromJSON (builtins.readFile ./fastfetch.json);
in
{
  programs.fastfetch = {
    enable = true;
    settings = json // {
      # "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        type = "kitty-direct";
        source = "${logo}";
        padding = {
          top = 4;
          right = 2;
          left = 2;
        };
      };
    };
  };

  home.shellAliases = {
    nf = "fastfetch";
    neofetch = "fastfetch";
    screenfetch = "fastfetch";
  };
}
