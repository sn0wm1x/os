{ osConfig, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Catppuccin Frappe";
      font-family = osConfig.fonts.fontconfig.defaultFonts.monospace;
    };
  };
}
