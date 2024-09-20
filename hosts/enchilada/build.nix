{
  imports = [ ./default.nix ];

  # https://nixos.wiki/wiki/NixOS_on_ARM#Build_your_own_image_natively
  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.hostPlatform.system = "aarch64-linux";
  nixpkgs.buildPlatform.system = "x86_64-linux";
}
