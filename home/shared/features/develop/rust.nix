{ pkgs, ... }: {
  home.packages = with pkgs; [
    cargo
    cargo-edit
    clippy
    rust-analyzer
    rustc
    rustfmt
  ];
}
