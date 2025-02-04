{ pkgs, ... }:
{
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      cweijan.vscode-database-client2
    ];
    userSettings = {
      "database-client.telemetry.usesOnlineServices" = false;
    };
  };
}
