{
  imports = [
    ./blackbox-terminal
    ./gnome
    ./messaging
    ./google-chrome.nix
    ./vscode.nix
    ./wezterm.nix
  ];

  dconf.enable = true;
}
