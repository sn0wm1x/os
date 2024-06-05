{ pkgs, ... }: {
  home.packages = with pkgs; [ tor-browser-bundle-bin ];
}
