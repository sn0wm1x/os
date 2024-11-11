# from https://github.com/NixOS/nixpkgs/pull/354870
{
  fetchFromGitea,
  git,
  lib,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "mergiraf";
  version = "0.2.0";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "mergiraf";
    repo = "mergiraf";
    rev = "refs/tags/v${version}";
    hash = "sha256-egtX2daCbPXi5rX2OxbEZA/VI9R4HMj5LRKbUEBFo+E=";
  };

  nativeCheckInputs = [ git ];

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "tree-sitter-go-0.23.1" = "sha256-elPqkvVYs0vADOuN/umDteWP5hqcXhQAoSkqYDtTxaU=";
      "tree-sitter-xml-0.7.0" = "sha256-RTWvOUAs3Uql9DKsP1jf9FZZHaZORE40GXd+6g6RQZw=";
      "tree-sitter-yaml-0.6.1" = "sha256-gS+SjOnGl/86U9VV/y1ca7naYIe7DAOvOv++jCRLTKo=";
    };
  };

  meta = {
    description = "A syntax-aware git merge driver for a growing collection of programming languages and file formats";
    mainProgram = "mergiraf";
    homepage = "https://codeberg.org/mergiraf/mergiraf";
    changelog = "https://codeberg.org/mergiraf/mergiraf/releases/tag/v${version}";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ kwaa ];
  };
}
