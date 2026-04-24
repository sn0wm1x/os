{ pkgs, config, ... }:
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

  home.sessionVariables = {
    # https://wiki.archlinux.org/title/XDG_Base_Directory#Partial
    CARGO_HOME = "${config.xdg.dataHome}/cargo";

    # Certain Rust tools won't work without this
    # https://wiki.nixos.org/wiki/Rust#Shell.nix_example
    RUST_SRC_PATH = pkgs.rust.packages.stable.rustPlatform.rustLibSrc;
  };

  home.persistence."/persist".directories = [
    ".local/share/cargo"
  ];
}
