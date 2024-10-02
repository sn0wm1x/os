self: super:

let
  gvc = super.fetchFromGitLab {
    domain = "gitlab.gnome.org";
    owner = "GNOME";
    repo = "libgnome-volume-control";
    rev = "5f9768a2eac29c1ed56f1fbb449a77a3523683b6";
    hash = "sha256-gdgTnxzH8BeYQAsvv++Yq/8wHi7ISk2LTBfU8hk12NM=";
  };
  version = "46.1";
  rev = "46-mobile.1";
in

{
  gnome-shell = super.gnome-shell.overrideAttrs (old: {
    inherit version;
    src = super.fetchFromGitLab {
      inherit rev;
      domain = "gitlab.gnome.org";
      owner = "verdre";
      repo = "gnome-shell-mobile";
      hash = "sha256-NL1/mddfaL1rMidsbtV4kG2SlAZZNuR8KmqTmEE4IAM=";
      fetchSubmodules = true;
    };
    buildInputs = old.buildInputs ++ [
      # JS ERROR: Error: Requiring ModemManager, version none: Typelib file for namespace 'ModemManager' (any version) not found
      # @resource:///org/gnome/shell/misc/modemManager.js:4:49
      super.modemmanager
    ];
    postPatch = ''
      patchShebangs src/data-to-c.pl
      ln -sf ${gvc} subprojects/gvc
    '';
  });

  mutter = super.mutter.overrideAttrs (old: {
    inherit version;
    src = super.fetchFromGitLab {
      inherit rev;
      domain = "gitlab.gnome.org";
      owner = "verdre";
      repo = "mutter-mobile";
      hash = "sha256-Xmoq//Igaz1oVt2/aLV+9WjZzW1g6yLADqg97wD3Lug=";
    };
  });

  gnome-control-center = super.gnome-control-center.overrideAttrs (old: {
    patches = old.patches ++ [
      # not ok /network-panel-wired/connection-multi-add-activate - test-network-panel:ERROR:../tests/network/test-network-panel.c:497:test_connection_multi_add_activate: 'find_label (GTK_WIDGET (fixture->shell), "52:54:00:ab:db:23")' should be NULL
      # https://gitlab.gnome.org/GNOME/gnome-control-center/-/issues/1768
      (super.fetchpatch {
        url = "https://sources.debian.org/data/main/g/gnome-control-center/1%3A46.4-1/debian/patches/debian/Ignore-result-of-test-network-panel.patch";
        hash = "sha256-7ELAOjT3n2p3mWKRS/3JXwvxWjODGXnfmpIx0dOc2LU=";
      })
    ];
  });
}
