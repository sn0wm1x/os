{ lib, pkgs, ... }:
{
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [ tamasfe.even-better-toml ];
    userSettings = {
      "evenBetterToml.taplo.bundled" = false;
      "evenBetterToml.taplo.path" = lib.getExe pkgs.taplo;
    };
  };
}
