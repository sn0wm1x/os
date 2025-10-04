{
  imports = [
    ./extensions
    ./file-nesting-config.nix
    ./settings.nix
  ];

  programs.vscode.enable = true;
  programs.vscode.defaultEditor = true;
  programs.vscode.profiles.default.enableUpdateCheck = false;
}
