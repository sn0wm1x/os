let
  wallpaper = ../../../../../assets/103085198_p0.jpg;
  # wallpaper = pkgs.fetchurl {
  #   # https://www.pixiv.net/artworks/103085198
  #   url = "https://i.pximg.net/img-original/img/2022/11/25/18/08/43/103085198_p0.jpg";
  #   hash = "sha256-BOy35x/9AGHCkY0fLTrwPTsyAvctwYUkrjDvzhLZzbM=";
  #   curlOptsList = [
  #     "-e"
  #     "https://www.pixiv.net/"
  #   ];
  # };
in
{
  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri = "file://${wallpaper}";
      picture-uri-dark = "file://${wallpaper}";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file://${wallpaper}";
    };
  };
}
