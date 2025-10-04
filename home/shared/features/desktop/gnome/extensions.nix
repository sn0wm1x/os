{ pkgs, ... }:
{
  home.packages = with pkgs.gnomeExtensions; [
    # 功能
    kimpanel
    coverflow-alt-tab
    easyeffects-preset-selector
    #
    paperwm
    dash-to-dock
    # 外观
    user-themes
    blur-my-shell
  ];

  dconf.settings."org/gnome/shell".disable-user-extensions = false;
  dconf.settings."org/gnome/shell".enabled-extensions = [
    "kimpanel@kde.org"
    "CoverflowAltTab@palatis.blogspot.com"
    "eepresetselector@ulville.github.io"

    "paperwm@paperwm.github.com"
    "dash-to-dock@micxgx.gmail.com"

    "user-theme@gnome-shell-extensions.gcampax.github.com"
    "blur-my-shell@aunetx"
  ];

  # Blur My Shell
  dconf.settings."org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
    blur = true;
    brightness = 0.6;
    override-background = true;
    pipeline = "pipeline_default_rounded";
    sigma = 30;
    static-blur = true;
    style-dash-to-dock = 1;
    unblur-in-overview = false;
  };

  # Dash to Dock
  dconf.settings."org/gnome/shell/extensions/dash-to-dock" = {
    intellihide-mode = "ALL_WINDOWS";
    running-indicator-style = "DASHES";
  };
}
