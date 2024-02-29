{ pkgs, ... }: {
  imports = [
    ./fcitx5.nix
    ./github-desktop.nix
    ./pipewire.nix
    ./vscode.nix
  ];

  environment.systemPackages = with pkgs; [
    github-desktop
    telegram-desktop
  ];
}
