{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;

    package = pkgs.wrapFirefox pkgs.librewolf-unwrapped {
      inherit (pkgs.librewolf-unwrapped) extraPrefsFiles extraPoliciesFiles;
      wmClass = "LibreWolf";
      libName = "librewolf";
    };

    configPath = "${config.xdg.configHome}/librewolf";

    profiles.kwa = {
      isDefault = true;
      id = 0;
      name = "kwa";

      search = {
        force = true;
        default = "startpage";
        privateDefault = "startpage";
      };

      settings = {
        # Enable WebGL
        # TODO: use CanvasBlocker
        # "webgl.disabled" = false;
        # Enable letterboxing
        "privacy.resistFingerprinting.letterboxing" = true;
      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = "librewolf.desktop";
    "x-scheme-handler/https" = "librewolf.desktop";
    "text/html" = "librewolf.desktop";
  };
}
