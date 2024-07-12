{ pkgs, ... }:
{
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    denoland.vscode-deno # javascript (deno)

    # Linter / Formatter
    dbaeumer.vscode-eslint # eslint

    # Library / Framework
    vue.volar # vue3
    svelte.svelte-vscode # svelte
  ];

  programs.vscode.userSettings = {
    "deno.enable" = false;
  };
}
