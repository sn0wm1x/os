{
  imports = [ ./default.nix ];

  # https://nixos.wiki/wiki/NixOS_on_ARM#Cross-compiling
  nixpkgs.crossSystem.system = "aarch64-linux";
}
