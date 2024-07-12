{ lib, pkgs, ... }:
{
  # programs.vscode.mutableExtensionsDir = false;
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [ tamasfe.even-better-toml ];
    programs.vscode.userSettings = {
      "evenBetterToml.taplo.bundled" = false;
      "evenBetterToml.taplo.path" = lib.getExe pkgs.taplo;
    };
  };
}
