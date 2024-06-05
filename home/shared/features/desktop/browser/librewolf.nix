{
  # https://nixos.wiki/wiki/Librewolf
  programs.librewolf.enable = true;
  programs.librewolf.settings = {
    # Enable WebGL
    "webgl.disabled" = false;
  };
}
