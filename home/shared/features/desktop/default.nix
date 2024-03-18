{
  imports = [
    ./blackbox-terminal
    ./gnome
    ./messaging
    ./vscode
    ./google-chrome.nix
  ];

  dconf.enable = true;
}
