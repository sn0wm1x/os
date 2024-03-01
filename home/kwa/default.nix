# https://github.com/Misterio77/nix-starter-configs/blob/main/minimal/home-manager/home.nix
{
  imports = [
    ../shared
    ../shared/features/cli
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
    allowOther = true;
  };
}
