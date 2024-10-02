{
  outputs,
  lib,
  pkgs,
  ...
}:
let
  mobile-config-firefox = outputs.packages.${pkgs.system}.mobile-config-firefox;
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      # https://github.com/NixOS/nixpkgs/blob/fbdb99df92d7c42e4cc12b307a4cf577241eed59/nixos/modules/programs/firefox.nix#L312-L315
      # autoConfigFiles = [ "${mobile-config-firefox}/lib/firefox/mobile-config-autoconfig.js" ];
      extraPoliciesFiles = [ "${mobile-config-firefox}/etc/firefox/policies/policies.json" ];
      extraPrefsFiles = [
        "${mobile-config-firefox}/lib/firefox/mobile-config-autoconfig.js"
        "${mobile-config-firefox}/lib/firefox/default/pref/mobile-config-prefs.js"
      ];
    };

    profiles.kwa =
      let
        concatFiles =
          dir:
          builtins.concatStringsSep "" (
            map (k: lib.optionalString (!lib.hasInfix ".before-ff" k) (builtins.readFile "${dir}/${k}")) (
              builtins.attrNames (builtins.readDir dir)
            )
          );
      in
      {
        isDefault = true;
        id = 0;
        name = "藍";

        userChrome =
          concatFiles "${mobile-config-firefox}/etc/mobile-config-firefox/common"
          + concatFiles "${mobile-config-firefox}/etc/mobile-config-firefox/userChrome";
        userContent =
          concatFiles "${mobile-config-firefox}/etc/mobile-config-firefox/common"
          + concatFiles "${mobile-config-firefox}/etc/mobile-config-firefox/userContent";
      };

    # https://github.com/nix-community/home-manager/pull/5195
    languagePacks = [ "zh-CN" ];
  };
}
