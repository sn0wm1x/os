{ pkgs, config, ... }:
{
  home = {
    packages = with pkgs; [
      blackbox-terminal
    ];
    # https://github.com/catppuccin/blackbox/blob/main/src/Catppuccin-Frappe.json
    file."${config.home.homeDirectory}/.local/share/blackbox/schemes/Catppuccin-Frappe.json".source = ./Catppuccin-Frappe.json;
    # https://github.com/catppuccin/blackbox/blob/main/src/Catppuccin-Latte.json
    file."${config.home.homeDirectory}/.local/share/blackbox/schemes/Catppuccin-Latte.json".source = ./Catppuccin-Latte.json;
  };
  dconf.settings = {
    "com/raggesilver/BlackBox" = {
      font = "MonospiceNe Nerd Font 14";
      theme-dark = "Catppuccin-Frappe";
      theme-light = "Catppuccin-Latte";
    };
  };
}
