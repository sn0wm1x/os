{
  lib,
  stdenvNoCC,
  fetchFromGitLab,
  ...
}:
# updated from https://github.com/chayleaf/dotfiles/blob/03332873d2fc05ea031019c31e7d39c4d7c8a3c2/pkgs/mobile-config-firefox/default.nix
stdenvNoCC.mkDerivation rec {
  pname = "mobile-config-firefox";
  version = "4.3.2";

  src = fetchFromGitLab {
    owner = "postmarketOS";
    repo = "mobile-config-firefox";
    rev = "refs/tags/${version}";
    sha256 = "sha256-AqRnf9wTr6sPLKgpHKFa/vgXBmiC7QulRpHP2ExdEPo=";
  };

  makeFlags = [
    "DESTDIR=$(out)"
    "FIREFOX_DIR=/lib/firefox"
  ];

  postInstall = ''
    rm -rf "$out/usr"
  '';

  meta = {
    description = "Mobile and privacy friendly configuration for Firefox (distro-independent)";
    homepage = "https://gitlab.com/postmarketOS/mobile-config-firefox";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ kwaa ];
    platforms = lib.platforms.all;
  };
}
