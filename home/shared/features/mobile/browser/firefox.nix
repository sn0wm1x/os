{ pkgs, ... }:
let
  mobile-config-firefox = pkgs.fetchFromGitLab {
    owner = "postmarketOS";
    repo = "mobile-config-firefox";
    rev = "refs/tags/4.3.2";
    sha256 = "sha256-AqRnf9wTr6sPLKgpHKFa/vgXBmiC7QulRpHP2ExdEPo=";
  };
  userChrome = pkgs.runCommand "userChrome.css" { } ''
    cat ${mobile-config-firefox}/src/userChrome/*.css > $out
  '';
  userContent = pkgs.runCommand "userContent.css" { } ''
    cat ${mobile-config-firefox}/src/userContent/*.css > $out
  '';
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      autoConfigFiles = [ "${mobile-config-firefox}/src/mobile-config-autoconfig.js" ];
      extraPoliciesFiles = [ "${mobile-config-firefox}/src/policies.json" ];
      extraPrefsFiles = [ "${mobile-config-firefox}/src/mobile-config-prefs.js" ];
    };

    profiles.kwa = {
      isDefault = true;
      id = 0;
      name = "藍";
      inherit userChrome userContent;
    };

    # https://github.com/nix-community/home-manager/pull/5195
    languagePacks = [ "zh-CN" ];
  };
}
