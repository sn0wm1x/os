final: prev: {
  gnome = prev.gnome.overrideScope (gnomeFinal: gnomePrev: {
    mutter = gnomePrev.mutter.overrideAttrs (old: {
      # https://nixos.wiki/wiki/GNOME#Dynamic_triple_buffering
      src = prev.pkgs.fetchFromGitLab {
        domain = "gitlab.gnome.org";
        owner = "vanvugt";
        repo = "mutter";
        rev = "triple-buffering-v4-46";
        hash = "sha256-fkPjB/5DPBX06t7yj0Rb3UEuu5b9mu3aS+jhH18+lpI=";
      };
    });
  });
}
