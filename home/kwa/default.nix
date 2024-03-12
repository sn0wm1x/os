# https://github.com/Misterio77/nix-starter-configs/blob/main/minimal/home-manager/home.nix
{ lib, ... }: {
  imports = [
    ../shared
    ../shared/features/audio
    ../shared/features/cli
    ../shared/features/desktop
    ../shared/features/develop
    ./programs
  ];

  home.username = "kwa";
  home.homeDirectory = "/home/kwa";
  home.persistence."/persist/home/kwa" = {
    # https://github.com/nix-community/impermanence#home-manager
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      ".nixos"
    ];
    allowOther = lib.mkForce true;
  };
}
