{ pkgs, ... }: {
  home.packages = with pkgs; [
    cargo
    cargo-edit
    clippy
    rust-analyzer
    rustc
    rustfmt
  ];

  # fix rust-analyzer
  home.sessionVariables = {
    RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
  };
}
