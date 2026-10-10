{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;

    package = pkgs.librewolf-bin.override {
      wmClass = "LibreWolf";
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

        # English only
        "intl.locale.requested" = "en-US";
        "intl.accept_languages" = "en-US,en";

        # Hide bookmarks
        "browser.toolbars.bookmarks.visibility" = "never";
      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = "librewolf.desktop";
    "x-scheme-handler/https" = "librewolf.desktop";
    "text/html" = "librewolf.desktop";
  };
}
