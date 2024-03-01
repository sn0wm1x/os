{
  programs.wezterm.enable = true;
  programs.wezterm.extraConfig = ''
    return {
      color_scheme = "Catppuccin Frappe",
    }
  '';
}
