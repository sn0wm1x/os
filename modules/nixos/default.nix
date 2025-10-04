# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  baseline = import ./baseline.nix;
  baseline-desktop = import ./baseline-desktop.nix;
  gaming = import ./gaming.nix;
  impermanence = import ./impermanence.nix;
  powersave = import ./powersave.nix;
}
