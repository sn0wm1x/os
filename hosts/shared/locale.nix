{ lib, ... }: {
  i18n = {
    # defaultLocale = lib.mkDefault "en_US.UTF-8";
    defaultLocale = lib.mkDefault "zh_CN.UTF-8";
    # extraLocaleSettings = {
    #   LC_TIME = lib.mkDefault "zh_CN.UTF-8";
    # };
    supportedLocales = lib.mkDefault [
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
      "zh_TW.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
  };
  time.timeZone = lib.mkDefault "Asia/Taipei";

  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  # TODO: https://github.com/catppuccin/fcitx5
}
