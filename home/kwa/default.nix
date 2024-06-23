# https://github.com/Misterio77/nix-starter-configs/blob/main/minimal/home-manager/home.nix
{ config
, lib
, pkgs
, osConfig
, ...
}:
let
  hostName = osConfig.networking.hostName;
in
{
  imports = [
    ../shared
    ../shared/features/audio
    ../shared/features/cli
    ../shared/features/desktop
    ../shared/features/develop
    ../shared/features/virtualisation
    ./programs
    (./. + "${hostName}")
  ];

  home.username = "kwa";
  home.homeDirectory = "/home/kwa";

  home.file.".face".source = pkgs.fetchurl {
    # https://www.pixiv.net/artworks/100897044
    url = "https://i.pximg.net/img-original/img/2022/08/31/19/32/36/100897044_p0.png";
    hash = "sha256-xO7ISZ/tT7HC8tV3apSVRTJxEpp5Ai6m5JzPPZvuCIo=";
    curlOptsList = [ "-e" "https://www.pixiv.net/" ];
  };

  home.persistence."/persist${config.home.homeDirectory}" = {
    # https://github.com/nix-community/impermanence#home-manager
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      ".os" # github:sn0wm1x/os
      ".nixos" # TODO: remove this
    ];
    allowOther = lib.mkForce true;
  };
}
