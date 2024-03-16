{
  imports = [
    ./blackbox-terminal
    ./gnome
    ./messaging
    ./google-chrome.nix
    ./vscode.nix
  ];

  dconf.enable = true;
}
