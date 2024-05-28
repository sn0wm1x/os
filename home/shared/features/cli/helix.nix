{ lib
, pkgs
, ...
}: {
  # https://nixos.wiki/wiki/Helix
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_frappe_transparent";
      editor = {
        lsp.display-messages = true;
        # https://github.com/catppuccin/helix#usage
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
      };
      keys.normal = {
        space = {
          space = "file_picker";
          w = ":w";
          q = ":q";
        };
        esc = [ "collapse_selection" "keep_primary_selection" ];
      };
    };
    themes.catppuccin_frappe_transparent = {
      "inherits" = "catppuccin_frappe";
      "ui.background" = { };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = lib.getExe pkgs.nixpkgs-fmt;
        # formatter.args = [];
        language-servers = [ "${lib.getExe pkgs.nil}" ];
      }
    ];
  };
}
