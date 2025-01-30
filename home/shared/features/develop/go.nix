{ pkgs, ... }:
{
  home.packages = with pkgs; [
    go
    gopls # lsp
    buf # protobuf toolchain
  ];
}
