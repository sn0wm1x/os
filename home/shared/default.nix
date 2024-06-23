{ inputs, lib, ... }: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ./xdg.nix
  ];

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = lib.mkDefault "23.11";
}
