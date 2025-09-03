{ pkgs, ... }:
{
  programs.vscode.profiles.default.extensions =
    (with pkgs.vscode-extensions; [
      # ruff
      charliermarsh.ruff
    ])
    ++ (with pkgs.vscode-marketplace; [
      # ty
      astral-sh.ty
    ]);
}
