{
  programs.starship.enable = true;
  programs.starship.catppuccin.enable = true;
  programs.starship.settings = {
    add_newline = true;
    character = {
      success_symbol = "[➜](bold green)";
      error_symbol = "[➜](bold red)";
    };
  };
}
