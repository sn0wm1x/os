{
  stdenv,
  fetchFromGitHub,
  autoconf-archive,
  autoreconfHook,
  ell,
  pkg-config,
  lib,
  ...
}:
stdenv.mkDerivation rec {
  pname = "mptcpd";
  version = "0.12";

  src = fetchFromGitHub {
    owner = "multipath-tcp";
    repo = "mptcpd";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-TFDbk/vHTZaWBS6MGy8A/0i9QS/NJN1+n/hruNReDyg=";
  };

  nativeBuildInputs = [
    autoconf-archive
    autoreconfHook
    ell
    pkg-config
  ];

  meta = {
    description = "Multipath TCP daemon";
    homepage = "https://github.com/multipath-tcp/mptcpd";
    platforms = lib.platforms.linux;
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ kwaa ];
  };
}
