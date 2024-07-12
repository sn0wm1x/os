{ pkgs, ... }:
{
  home.packages = with pkgs.gnomeExtensions; [
    # 功能
    kimpanel
    gsconnect
    easyeffects-preset-selector
    system76-scheduler
    #
    paperwm
    dash-to-dock
    quick-settings-tweaker
    # 外观
    user-themes
    blur-my-shell
    just-perfection
    # rounded-window-corners # legacy
    gnome-40-ui-improvements
  ];

  dconf.settings."org/gnome/shell".disable-user-extensions = false;
  dconf.settings."org/gnome/shell".enabled-extensions = [
    "kimpanel@kde.org"
    "gsconnect@andyholmes.github.io"
    "eepresetselector@ulville.github.io"
    "s76-scheduler@mattjakeman.com"

    "paperwm@paperwm.github.com"
    "dash-to-dock@micxgx.gmail.com"
    "quick-settings-tweaks@qwreey"

    "user-theme@gnome-shell-extensions.gcampax.github.com"
    "blur-my-shell@aunetx"
    "just-perfection-desktop@just-perfection"
    # rounded-window-corners
    "gnomeExtensions.gnome-40-ui-improvements@AXP.com"
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
