{ pkgs, ... }:
let
  # TODO: remove hotfix
  # https://github.com/NixOS/nixpkgs/issues/560776#issuecomment-5569887181
  vscode = pkgs.vscode.overrideAttrs (old: {
    postPatch = old.postPatch + ''
      rm -rf "resources/app/node_modules.asar.unpacked"
      ln -rs "resources/app/node_modules" "resources/app/node_modules.asar.unpacked"
    '';
  });
in
{
  imports = [
    ./extensions
    ./file-nesting-config.nix
    ./settings.nix
  ];

  programs.vscode = {
    enable = true;
    package = vscode;
  };
  programs.vscode.profiles.default.enableUpdateCheck = false;

  # does not exist in home-manager
  # programs.vscode.defaultEditor = true;
  home.sessionVariables.EDITOR = "vscode";
}
