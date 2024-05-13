{
  imports = [
    ./blackbox-terminal
    ./gnome
    ./messaging
    ./misc
    ./vscode
    ./google-chrome.nix
    ./ptyxis.nix
  ];

  dconf.enable = true;
}
