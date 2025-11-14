{ pkgs, ... }:
{
  programs.vscode.profiles.default.extensions =
    (with pkgs.vscode-extensions; [
      ms-python.python
      # ruff
      charliermarsh.ruff
    ])
    ++ (with pkgs.vscode-marketplace; [
      # pyrefly (lsp)
      meta.pyrefly
    ]);
}
