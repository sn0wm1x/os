{ pkgs, ... }:
{
  imports = [
    ./github.nix
    ./javascript.nix
    ./nix.nix
    ./toml.nix
  ];

  # programs.vscode.mutableExtensionsDir = false;
  programs.vscode.extensions = with pkgs.vscode-extensions; ([
    # Theme
    catppuccin.catppuccin-vsc
    catppuccin.catppuccin-vsc-icons
    # Enhancement
    usernamehw.errorlens
    streetsidesoftware.code-spell-checker
    eamodio.gitlens
    mhutchie.git-graph
    editorconfig.editorconfig
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
  ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      # https://www.dependi.io
      name = "dependi";
      publisher = "fill-labs";
      version = "0.7.2";
      sha256 = "S3R1oLk7facP5Rn9czmHlffhMtLNrSaGYbaU3/x6/aM=";
    }
  ];
}
