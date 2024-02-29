{ outputs, inputs, lib, config, pkgs, ... }: {
  imports = [
    # ./fonts.nix
  ];

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = lib.mkDefault "23.11";
}
