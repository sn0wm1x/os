{ lib, pkgs, ... }: {
  programs.vscode.enable = true;
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    ## Theme
    catppuccin.catppuccin-vsc
    catppuccin.catppuccin-vsc-icons
    ## Enhancement
    ### git
    eamodio.gitlens
    ### misc
    editorconfig.editorconfig
    mkhl.direnv
    ## Languages
    jnoortheen.nix-ide # https://github.com/nix-community/vscode-nix-ide
  ];
  programs.vscode.userSettings = {
    "workbench.colorTheme" = "Catppuccin Frappé";
    "workbench.iconTheme" = "catppuccin-frappe";

    "nix.enableLanguageServer" = true;
    "nix.formatterPath" = "${lib.getExe pkgs.alejandra}";
    "nix.serverPath" = "${lib.getExe pkgs.nil}";
    "nix.serverSettings"."nil"."formatting"."command" = [ "${lib.getExe pkgs.alejandra}" ];
  };
}