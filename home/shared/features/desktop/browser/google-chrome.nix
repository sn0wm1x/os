{
  # inputs,
  pkgs,
  ...
}:
{
  home.packages =
    # google-chrome
    (
      with pkgs;
      [
        (google-chrome.override {
          # force ozone wayland & fcitx5 wayland fix
          # https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland#Chromium_.2F_Electron
          commandLineArgs = "--ozone-platform=wayland --enable-wayland-ime --wayland-text-input-version=3";
        })
      ]
    );
  # google-chrome-dev / google-chrome-unstable
  # ++ (with inputs.browser-previews.packages.${pkgs.system}; [
  #   (google-chrome-dev.override {
  #     # use text-input-v3
  #     # https://github.com/chromium/chromium/commit/5874fc33585ded8316f6a4336a25da64dc2a7027
  #     commandLineArgs = "--ozone-platform=wayland --enable-wayland-ime --wayland-text-input-version=3";
  #   })
  # ]);

  # https://wiki.archlinux.org/title/Profile-sync-daemon
  services.psd.enable = true;
  services.psd.browsers = [ "google-chrome" ];

  # home.file.".config/google-chrome".force = true;
  home.persistence."/persist".directories = [ ".config/google-chrome" ];
  # ~/.config/google-chrome-unstable symlink
  # home.file.".config/google-chrome-unstable".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/google-chrome";
}
