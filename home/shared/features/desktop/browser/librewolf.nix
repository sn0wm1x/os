{ config, pkgs, ... }:
let
  firefox-gnome-theme = pkgs.fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = "firefox-gnome-theme";
    rev = "v126";
    hash = "sha256-jVbj2JD5GRkP8s3vKBtd9PDpftf3kjLR0ZA/ND/c2+Q=";
  };
  betterfox = pkgs.fetchFromGitHub {
    owner = "yokoffing";
    repo = "Betterfox";
    rev = "126.0";
    hash = "sha256-W0JUT3y55ro3yU23gynQSIu2/vDMVHX1TfexHj1Hv7Q=";
  };
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.librewolf-unwrapped {
      inherit (pkgs.librewolf-unwrapped) extraPrefsFiles extraPoliciesFiles;
      wmClass = "LibreWolf";
      libName = "librewolf";
    };

    # https://github.com/nix-community/home-manager/pull/5195
    # languagePacks = [ "zh-CN" ];

    profiles.kwa = {
      isDefault = true;
      id = 0;
      name = "藍";

      search.default = "StartPage";
      search.privateDefault = "StartPage";

      settings = {
        # Enable WebGL
        # TODO: use CanvasBlocker
        "webgl.disabled" = false;
        # Enable letterboxing
        "privacy.resistFingerprinting.letterboxing" = true;
      };

      # firefox-gnome-theme
      userContent = builtins.readFile "${firefox-gnome-theme}/userContent.css";
      userChrome = builtins.readFile "${firefox-gnome-theme}/userChrome.css";

      extraConfig = builtins.concatStringsSep "\n" [
        (builtins.readFile "${firefox-gnome-theme}/configuration/user.js")
        (builtins.readFile "${betterfox}/Fastfox.js")
        (builtins.readFile "${betterfox}/Peskyfox.js")
        (builtins.readFile "${betterfox}/Smoothfox.js")
      ];
    };
  };

  home.file.".mozilla/firefox/profiles.ini".target = ".librewolf/profiles.ini";
  home.file.".librewolf/kwa".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.mozilla/firefox/kwa";
}
