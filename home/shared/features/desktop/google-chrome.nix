{ pkgs, ... }: {
  home.packages = with pkgs; [
    # google-chrome
    (google-chrome.override {
      # fcitx5 wayland fix
      # https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland#Chromium_.2F_Electron
      # commandLineArgs = "--gtk-version=4";
      commandLineArgs = "--enable-wayland-ime";
    })
  ];
  home.persistence."/persist/home/kwa".directories = [
    ".config/google-chrome"
  ];
}
