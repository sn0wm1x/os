{ lib, pkgs, ... }: {
  programs.vscode.enable = true;
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    # Theme
    catppuccin.catppuccin-vsc
    catppuccin.catppuccin-vsc-icons
    # Enhancement
    eamodio.gitlens
    mhutchie.git-graph
    editorconfig.editorconfig
    mkhl.direnv
    # Languages
    # https://github.com/nix-community/vscode-nix-ide
    jnoortheen.nix-ide
    # rust
    rust-lang.rust-analyzer
  ];
  programs.vscode.userSettings = let
  editor = {
    "editor.formatOnSave" = true;
  };
  explorer = {
    "explorer.confirmDelete" = false;
    "explorer.confirmDragAndDrop" = false;
  };
  workbench = {
    "workbench.colorTheme" = "Catppuccin Frappé";
    "workbench.iconTheme" = "catppuccin-frappe";
    "workbench.startupEditor" = "none";
  };
  git = {
    "git.autofetch" = true;
    "git.enableSmartCommit" = true;
  };
  formatter = {
    "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
  };
  nix = {
    "nix.enableLanguageServer" = true;
    "nix.formatterPath" = lib.getExe pkgs.alejandra;
    "nix.serverPath" = lib.getExe pkgs.nil;
    "nix.serverSettings"."nil"."formatting"."command" = [ "${lib.getExe pkgs.alejandra}" ];
  };
  in {
    "extensions.autoCheckUpdates" = false;
    "extensions.ignoreRecommendations" = true;
    "update.mode" = "none";
  }
  // editor
  // explorer
  // workbench
  // git
  // formatter
  // nix;
}