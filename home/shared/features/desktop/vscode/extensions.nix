{ pkgs, ... }: {
  # programs.vscode.mutableExtensionsDir = false;
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
    redhat.vscode-yaml # yaml
    redhat.vscode-xml # xml
    tamasfe.even-better-toml # toml
    jnoortheen.nix-ide # nix
    rust-lang.rust-analyzer # rust
    denoland.vscode-deno # javascript (deno)
  ];

  programs.vscode.userSettings = {
    "deno.enable" = false;
  };
}
