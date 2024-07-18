{ pkgs, ... }:
{
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    denoland.vscode-deno # javascript (deno)

    # Linter / Formatter
    dbaeumer.vscode-eslint # eslint

    # Library / Framework
    vue.volar # vue3
    svelte.svelte-vscode # svelte
  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    # THREE.js / R3F / WebXR
    {
      # https://volu.dev
      name = "volumetrics";
      publisher = "Volumetrics";
      version = "0.1.7";
      sha256 = "S3R1oLk7facP5Rn9czmHlffhMtLNrSaGYbaU3/x6/aM=";
    }
  ];

  programs.vscode.userSettings = {
    "deno.enable" = false;
  };
}
