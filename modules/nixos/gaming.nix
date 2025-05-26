{
  outputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.sn0wm1x.gaming;
in
with lib;
{
  options.sn0wm1x.gaming = {
    enable = mkEnableOption "SN0WM1X gaming configurations";
  };
  config = lib.mkIf cfg.enable {
    # https://wiki.nixos.org/wiki/Steam#Configuration
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;

      # https://wiki.nixos.org/wiki/Steam#Gamescope_Compositor_/_%22Boot_to_Steam_Deck%22
      gamescopeSession.enable = true;

      # https://wiki.nixos.org/wiki/Steam#Proton
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    # https://wiki.nixos.org/wiki/Steam#Gamescope_Compositor_/_%22Boot_to_Steam_Deck%22
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    # https://wiki.nixos.org/wiki/GameMode
    programs.gamemode.enable = true;

    # TODO: nvidia-offload

    # https://wiki.nixos.org/wiki/Steam#FHS_environment_only
    environment.systemPackages = with pkgs; [ steam-run ];

    # Home Manager Module
    home-manager = {
      sharedModules = [ outputs.homeManagerModules.gaming ];
      users.kwa = {
        sn0wm1x.gaming.enable = true;
      };
    };
  };
}
