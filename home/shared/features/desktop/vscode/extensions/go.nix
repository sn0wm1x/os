{ pkgs, ... }:
{
  programs.vscode.extensions = with pkgs.vscode-extensions; [ golang.go ];
}
