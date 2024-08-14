{ config
, inputs
, lib
, outputs
, ...
}:
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = builtins.attrValues outputs.overlays;

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 30d";

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = "nix-command flakes";
    extra-substituters = [ "https://sn0wm1x.cachix.org" ];
    extra-trusted-public-keys = [ "sn0wm1x.cachix.org-1:osOGZnIhSALHVbNcjx9pJIcqNCieQp8I5asyf2IPZFc=" ];
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; })) (
    (lib.filterAttrs (_: lib.isType "flake")) inputs
  );
  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc = lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;
}
