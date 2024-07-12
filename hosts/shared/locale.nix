{ lib, options, ... }:
{
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

  # use ntpd-rs instead of systemd-timesyncd
  services.timesyncd.enable = false;
  services.ntpd-rs.enable = true;
  # https://nixos.wiki/wiki/NTP
  networking.timeServers = [ "ntp.felixc.at" ] ++ options.networking.timeServers.default;

  # time.hardwareClockInLocalTime = lib.mkForce true;
  # # https://www.linuxfromscratch.org/lfs/view/9.0-systemd-rc1/chapter07/clock.html
  # environment.etc.adjtime.text = ''
  #   0.0 0 0.0
  #   0
  #   LOCAL
  # '';
}
