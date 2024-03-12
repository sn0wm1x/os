{
  imports = [
    ./blackbox-terminal
    ./gnome
    ./messaging
    ./github-desktop.nix
    ./google-chrome.nix
    ./vscode.nix
    ./wezterm.nix
  ];

  dconf.enable = true;
}
