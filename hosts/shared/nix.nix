{
  config,
  inputs,
  lib,
  outputs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = builtins.attrValues outputs.overlays;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 3";
    flake = "/persist/home/kwa/.os";
  };

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = "nix-command flakes";
    extra-substituters = [
      "https://sn0wm1x.cachix.org"
      # https://wiki.nixos.org/wiki/CUDA#Setting_up_CUDA_Binary_Cache
      "https://nix-community.cachix.org"
      # "https://nyx.chaotic.cx"
    ];
    extra-trusted-public-keys = [
      "sn0wm1x.cachix.org-1:osOGZnIhSALHVbNcjx9pJIcqNCieQp8I5asyf2IPZFc="
      # https://wiki.nixos.org/wiki/CUDA#Setting_up_CUDA_Binary_Cache
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # "nyx.chaotic.cx-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      # "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
    ];
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; })) (
    (lib.filterAttrs (_: lib.isType "flake")) inputs
  );
  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;
}
