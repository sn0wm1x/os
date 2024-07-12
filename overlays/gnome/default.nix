final: prev: {
  gnome = prev.gnome.overrideScope (
    gnomeFinal: gnomePrev: {
      mutter = gnomePrev.mutter.overrideAttrs (old: {
        # https://nixos.wiki/wiki/GNOME#Dynamic_triple_buffering
        src = prev.pkgs.fetchFromGitLab {
          domain = "gitlab.gnome.org";
          owner = "vanvugt";
          repo = "mutter";
          rev = "triple-buffering-v4-46";
          hash = "sha256-fkPjB/5DPBX06t7yj0Rb3UEuu5b9mu3aS+jhH18+lpI=";
        };

        # https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=mutter-text-input-v1
        patches = [
          # grab.patch
          (prev.fetchpatch {
            url = "https://gitlab.gnome.org/GNOME/mutter/-/commit/a99e139a68bd4e5350033163dfd85b6ce6da92a2.patch";
            hash = "sha256-QyMRJ8QNxEj/WNfQM2TzZ5vq0xg33hlaE8UgjHM25Zs=";
          })
          # text-input-v1.patch
          (prev.fetchpatch {
            url = "https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/3751/diffs.patch";
            hash = "sha256-KOpYon8Ajzn60voOAnj6wqXxZ7nnnJ9RIPhjGBKS5uY=";
          })
        ];
      });
    }
  );
}
