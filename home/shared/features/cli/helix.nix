{ lib, pkgs, ... }: {
  # https://nixos.wiki/wiki/Helix
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_frappe_transparent";
      # https://github.com/catppuccin/helix#usage
      editor.line-number = "relative";
      editor.cursorline = true;
      editor.color-modes = true;
      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      editor.indent-guides.render = true;
    };
    themes.catppuccin_frappe_transparent = {
      "inherits" = "catppuccin_frappe";
      "ui.background" = {};
    };
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = lib.getExe pkgs.alejandra;
      formatter.args = [ "--quiet" ];
      languages-server = lib.getExe pkgs.nil;
    }];
  };
}