{ pkgs, ... }:
{
  home.packages = with pkgs.gnomeExtensions; [
    # 功能
    kimpanel
    easyeffects-preset-selector
    # 关键
    paperwm
    dash-to-dock
    # 外观
    user-themes
    blur-my-shell
  ];

  dconf.settings."org/gnome/shell".disable-user-extensions = false;
  dconf.settings."org/gnome/shell".enabled-extensions = with pkgs.gnomeExtensions; [
    kimpanel.extensionUuid
    easyeffects-preset-selector.extensionUuid
    paperwm.extensionUuid
    dash-to-dock.extensionUuid
    user-themes.extensionUuid
    blur-my-shell.extensionUuid
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
