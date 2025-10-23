{ pkgs, ... }:
{
  imports = [
    ./ai.nix
    ./github.nix
    ./javascript.nix
    ./nix.nix
    ./python.nix
    ./toml.nix
  ];

  # programs.vscode.mutableExtensionsDir = false;
  programs.vscode.profiles.default = {
    extensions =
      (with pkgs.vscode-extensions; [
        # Theme
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        # Enhancement
        usernamehw.errorlens
        streetsidesoftware.code-spell-checker
        editorconfig.editorconfig
        mikestead.dotenv
        mkhl.direnv
        foam.foam-vscode # Personal knowledge management
        # Natural Languages
        ms-ceintl.vscode-language-pack-zh-hans
        # ms-ceintl.vscode-language-pack-zh-hant
        # ms-ceintl.vscode-language-pack-ja
        # Programming Languages
        redhat.vscode-yaml # yaml
        redhat.vscode-xml # xml
        rust-lang.rust-analyzer # rust
        vadimcn.vscode-lldb # rust debugger
      ])
      ++ (with pkgs.vscode-marketplace; [
        # https://www.dependi.io
        fill-labs.dependi
        # gitlens alternative
        mk12.better-git-line-blame
        # open in github
        antfu.open-in-github-button
      ]);

    userSettings = {
      "cSpell.allowCompoundWords" = true;
      "cSpell.language" = "en,en-US";
    };
  };
}
