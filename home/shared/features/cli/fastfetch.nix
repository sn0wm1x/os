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
      # "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        type = "kitty-direct"; # TODO: remove this
        source = "${logo}";
      };
      # https://github.com/fastfetch-cli/fastfetch/blob/dev/presets/screenfetch.jsonc
      modules = [
        "title"
        "os"
        "kernel"
        "uptime"
        {
          "type" = "packages";
          "format" = "{all}";
        }
        "shell"
        {
          "type" = "display";
          "key" = "Resolution";
          "compactType" = "original";
        }
        "de"
        "wm"
        "wmtheme"
        {
          "type" = "terminalfont";
          "key" = "font";
        }
        {
          "type" = "disk";
          "folders" = "/";
          "key" = "Disk";
        }
        "cpu"
        "gpu"
        {
          "type" = "memory";
          "key" = "RAM";
        }
      ];
    };
  };

  home.shellAliases = {
    nf = "fastfetch";
    neofetch = "fastfetch";
  };
}
