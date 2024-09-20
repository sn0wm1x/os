{ pkgs, ... }:
let
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
    package = pkgs.firefox-mobile;

    # https://github.com/nix-community/home-manager/pull/5195
    languagePacks = [ "zh-CN" ];

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

      extraConfig = ''
        ${builtins.readFile "${betterfox}/Fastfox.js"}
        ${builtins.readFile "${betterfox}/Peskyfox.js"}
        ${builtins.readFile "${betterfox}/Smoothfox.js"}
      '';
    };
  };
}
