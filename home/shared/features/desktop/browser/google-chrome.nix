{ pkgs, ... }:
let
  commandLineArgs = [
    # force ozone wayland & fcitx5 wayland fix
    # https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland#Chromium_.2F_Electron
    "--ozone-platform=wayland --enable-wayland-ime --wayland-text-input-version=3"
  ];
in
{
  home.packages = with pkgs; [
    (google-chrome.override {
      inherit commandLineArgs;
    })
  ];

  # https://wiki.archlinux.org/title/Profile-sync-daemon
  services.psd.enable = true;
  services.psd.browsers = [ "google-chrome" ];

  # home.file.".config/google-chrome".force = true;
  home.persistence."/persist".directories = [ ".config/google-chrome" ];
}
