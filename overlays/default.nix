{ ... }:
# from https://github.com/nix-community/nur-combined/commit/7df261f5c5bb9dab577944e757d13b4fc7c2d1f9
let
  files = builtins.readDir ./.;
  overlays = builtins.removeAttrs files [ "default.nix" ];
in
builtins.mapAttrs (name: _: import "${./.}/${name}") overlays
