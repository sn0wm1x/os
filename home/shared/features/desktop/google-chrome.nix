{pkgs, ...}: {
  home.packages = with pkgs; [
    # google-chrome
    (google-chrome.override {
      # force ozone wayland & fcitx5 wayland fix
      # https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland#Chromium_.2F_Electron
      commandLineArgs = "--ozone-platform=wayland --gtk-version=4";
    })
  ];
  home.persistence."/persist/home/kwa".directories = [
    ".config/google-chrome"
  ];
}
