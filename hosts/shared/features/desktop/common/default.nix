{ pkgs, ... }: {
  imports = [
    ./fcitx5.nix
    ./pipewire.nix
    ./vscode.nix
  ];

  environment.systemPackages = with pkgs; [
    github-desktop
    telegram-desktop
    google-chrome
  ];
}
