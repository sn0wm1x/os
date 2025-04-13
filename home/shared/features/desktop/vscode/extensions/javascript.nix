{ pkgs, ... }:
{
  programs.vscode.profiles.default = {
    extensions =
      with pkgs.vscode-extensions;
      [
        denoland.vscode-deno # javascript (deno)

        # Linter / Formatter
        dbaeumer.vscode-eslint # eslint

        # Library / Framework
        astro-build.astro-vscode # astro
        svelte.svelte-vscode # svelte
        unifiedjs.vscode-mdx # mdx
        vue.volar # vue3
      ]
      ++ (with pkgs.vscode-marketplace; [
        # THREE.js / R3F / WebXR
        volumetrics.volumetrics
        # UnoCSS
        antfu.unocss
        # HTML/CSS Tagged Template Literals
        ms-fast.fast-tagged-templates
      ]);

    userSettings = {
      "deno.enable" = false;
    };
  };
}
