{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # rust-toolchain
    cargo
    clippy
    rust-analyzer
    rustc
    rustfmt

    # cc linker
    gcc

    # openssl
    pkg-config
    openssl

    # cargo extensions
    cargo-nextest
    cargo-edit
    cargo-bloat

    # watcher
    bacon
  ];

  # Certain Rust tools won't work without this
  # https://nixos.wiki/wiki/Rust#Shell.nix_example
  home.sessionVariables = {
    RUST_SRC_PATH = pkgs.rust.packages.stable.rustPlatform.rustLibSrc;
  };
}
