final: prev: {
  mutter = prev.mutter.overrideAttrs (old: {
    # https://nixos.wiki/wiki/GNOME#Dynamic_triple_buffering
    src = prev.pkgs.fetchFromGitLab {
      domain = "gitlab.gnome.org";
      owner = "vanvugt";
      repo = "mutter";
      rev = "triple-buffering-v4-47";
      hash = "sha256-JaqJvbuIAFDKJ3y/8j/7hZ+/Eqru+Mm1d3EvjfmCcug=";
    };
  });
}
