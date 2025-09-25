{ pkgs, ... }:
let
  logo = pkgs.fetchurl {
    url = "https://github.com/sn0wm1x.png";
    hash = "sha256-7gAf++UN5o7+aP8jLno46zaEtni7vwNBrxD1pDkcA3A=";
  };
in
{
  programs.fastfetch = {
    enable = true;
    settings = {
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
      modules = [
        "break"
        {
          "type" = "custom";
          "format" = "\u001b[90m┌──────────────────────Hardware──────────────────────┐";
        }
        {
          type = "host";
          key = "├{icon}";
          keyColor = "blue";
        }
        {
          type = "cpu";
          key = "├{icon}";
          showPeCoreCount = true;
          keyColor = "blue";
        }
        {
          type = "gpu";
          key = "├{icon}";
          detectionMethod = "pci";
          keyColor = "blue";
        }
        {
          type = "display";
          key = "├{icon}";
          keyColor = "blue";
        }
        {
          type = "disk";
          folders = "/";
          key = "├{icon}";
          keyColor = "blue";
        }
        {
          type = "memory";
          key = "├{icon}";
          keyColor = "blue";
        }
        {
          type = "custom";
          format = "\u001b[90m└────────────────────────────────────────────────────┘";
        }
        "break"
        {
          type = "custom";
          format = "\u001b[90m┌──────────────────────Software──────────────────────┐";
        }
        {
          type = "os";
          format = "SN0WM1X (Nix) OS ({11}, {12})";
          key = "├󱄅";
          keyColor = "magenta";
        }
        {
          type = "kernel";
          key = "├";
          keyColor = "magenta";
        }
        {
          type = "packages";
          key = "├{icon}";
          keyColor = "magenta";
        }
        {
          type = "shell";
          key = "├{icon}";
          keyColor = "magenta";
        }
        {
          type = "de";
          key = "├{icon}";
          keyColor = "magenta";
        }
        {
          type = "wm";
          key = "├{icon}";
          keyColor = "magenta";
        }
        {
          type = "wmtheme";
          key = "├{icon}";
          keyColor = "magenta";
        }
        {
          type = "uptime";
          key = "├{icon}";
          keyColor = "magenta";
        }
        {
          type = "custom";
          format = "\u001b[90m└────────────────────────────────────────────────────┘";
        }
        "break"
      ];
    };
  };

  home.shellAliases = {
    nf = "fastfetch";
    neofetch = "fastfetch";
  };
}
