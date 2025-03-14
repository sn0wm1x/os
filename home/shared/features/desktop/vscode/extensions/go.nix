{ pkgs, ... }:
{
  programs.vscode.extensions =
    (with pkgs.vscode-extensions; [
      golang.go
    ])
    ++ (with pkgs.vscode-marketplace; [
      # protobuf
      bufbuild.vscode-buf
    ]);
}
