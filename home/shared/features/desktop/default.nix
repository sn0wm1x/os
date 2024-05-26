{
  imports = [
    ./blackbox-terminal
    ./gnome
    ./messaging
    ./misc
    ./vscode
    ./google-chrome.nix
  ];

  dconf.enable = true;
}
