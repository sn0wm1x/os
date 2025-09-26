let
  editor = {
    "editor.tabSize" = 2;
  };
  explorer = {
    "explorer.confirmDelete" = false;
    "explorer.confirmDragAndDrop" = false;
  };
  files = {
    "files.eol" = "\n";
    "files.insertFinalNewline" = true;
    "files.simpleDialog.enable" = true;
  };
  workbench = {
    "workbench.colorTheme" = "Catppuccin Frappé";
    "workbench.iconTheme" = "catppuccin-frappe";
    "workbench.startupEditor" = "none";
  };
  git = {
    "git.allowForcePush" = true;
    "git.autofetch" = true;
    "git.confirmSync" = false;
    "git.enableSmartCommit" = true;
    "git.untrackedChanges" = "separate";
  };
in
{
  programs.vscode.profiles.default.userSettings = {
    "extensions.autoCheckUpdates" = false;
    "extensions.ignoreRecommendations" = true;
    "update.mode" = "none";
    # https://gist.github.com/hyperupcall/99e355405611be6c4e0a38b6e3e8aad0
    "telemetry.telemetryLevel" = "off";
    # Extensions
    "gitlens.showWelcomeOnInstall" = false;
    "gitlens.showWhatsNewAfterUpgrades" = false;
    "redhat.telemetry.enabled" = false;
  }
  // editor
  // explorer
  // files
  // workbench
  // git;
}
