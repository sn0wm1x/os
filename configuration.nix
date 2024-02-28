{
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.auto-optimise-store = true;

  users.mutableUsers = false;
  users.users.root.initialPassword = "20240229";
  users.users.kwa.initialPassword = "20240229";
  users.users.kwa.extraGroups = [ "wheel" ];
  users.users.kwa.isNormalUser = true;
}
