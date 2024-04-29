{pkgs, ...}: {
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
}
