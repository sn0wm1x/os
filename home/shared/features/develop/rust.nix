{ pkgs, ... }: {
  home.packages = with pkgs; [
    cargo
    cargo-edit
    clippy
    rust-analyzer
    rustc
    rustfmt
  ];

  # Certain Rust tools won't work without this
  # https://nixos.wiki/wiki/Rust#Shell.nix_example
  home.sessionVariables = {
    RUST_SRC_PATH = pkgs.rust.packages.stable.rustPlatform.rustLibSrc;
  };
}
