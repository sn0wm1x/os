{
  imports = [
    ./extensions
    ./file-nesting-config.nix
    ./settings.nix
  ];

  programs.vscode.enable = true;
  programs.vscode.profiles.default.enableUpdateCheck = false;

  # does not exist in home-manager
  # programs.vscode.defaultEditor = true;
  home.sessionVariables.EDITOR = "vscode";
}
