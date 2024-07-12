{
  imports = [
    ./extensions
    ./settings.nix
  ];

  programs.vscode.enable = true;
  programs.vscode.enableUpdateCheck = false;
}
