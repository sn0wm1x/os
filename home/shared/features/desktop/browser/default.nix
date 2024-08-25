{
  imports = [
    ./google-chrome.nix
    # TODO: enable librewolf
    # https://github.com/NixOS/nixpkgs/pull/336304
    # ./librewolf.nix
    ./tor-browser.nix
  ];
}
