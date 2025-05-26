{
  inputs,
  config,
  lib,
  osConfig,
  ...
}:
let
  cfg = config.sn0wm1x.baseline-desktop;
in
with lib;
{
  options.sn0wm1x.baseline-desktop = {
    enable = mkEnableOption "SN0WM1X baseline-desktop configurations";
  };
  config = lib.mkIf cfg.enable {
    home.username = "kwa";
    home.homeDirectory = "/home/kwa";

    home.file.".face".source = ../../assets/100897044_p0.png;

    # https://nix.catppuccin.com/options/home-manager-options.html
    imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];
    catppuccin = {
      flavor = osConfig.catppuccin.flavor;
      accent = osConfig.catppuccin.accent;
    };

    xdg = {
      enable = true;
      # mime
      mime.enable = true;
      mimeApps.enable = true;
      configFile."mimeapps.list".force = true;
      # user-dirs
      configFile."user-dirs.locale".text = lib.mkForce "en_US";
      userDirs = {
        enable = true;
        createDirectories = true;
        music = "${config.home.homeDirectory}/Music";
        videos = "${config.home.homeDirectory}/Videos";
        pictures = "${config.home.homeDirectory}/Pictures";
        desktop = "${config.home.homeDirectory}/Desktop";
        download = "${config.home.homeDirectory}/Downloads";
        templates = "${config.home.homeDirectory}/Templates";
        documents = "${config.home.homeDirectory}/Documents";
        publicShare = "${config.home.homeDirectory}/Public";
        extraConfig = {
          XDG_SCREENSHOTS_DIR = "${config.pictures}/Screenshots";
        };
      };
    };
  };
}
