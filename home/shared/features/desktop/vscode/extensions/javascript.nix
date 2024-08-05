{ pkgs, ... }:
{
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    denoland.vscode-deno # javascript (deno)

    # Linter / Formatter
    dbaeumer.vscode-eslint # eslint

    # Library / Framework
    astro-build.astro-vscode # astro
    vue.volar # vue3
    svelte.svelte-vscode # svelte
  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    # THREE.js / R3F / WebXR
    {
      # https://volu.dev
      name = "volumetrics";
      publisher = "Volumetrics";
      version = "0.1.7";
      sha256 = "4QmSQJjuEach+B9Q2muQ4iVRak40l2yK+5z0RV+58eo=";
    }
  ];

  programs.vscode.userSettings = {
    "deno.enable" = false;
  };
}
