{
  lib,
  stdenv,
  fetchurl,
  unzip,
  autoPatchelfHook,
}:

let
  version = "1.5.2";
  sources = {
    x86_64-linux = {
      arch = "x86_64";
      hash = "sha256-md2GEkUIBQEWGde4RHzjdMKJ4AVJ2FV/NnkOHdYlaFI=";
    };
    aarch64-linux = {
      arch = "arm64";
      hash = "sha256-5yngXvVO8HY+SJAAMkZrR/p8mTnN4lf5O6SUEKtXess=";
    };
  };
  source =
    sources.${stdenv.hostPlatform.system}
      or (throw "Unsupported platform: ${stdenv.hostPlatform.system}");
in
stdenv.mkDerivation {
  pname = "antigravity-acp";
  inherit version;

  src = fetchurl {
    url = "https://dl.google.com/agy-extensions/releases/linux/agy-acp-server-${version}-linux-${source.arch}.zip";
    inherit (source) hash;
  };

  nativeBuildInputs = [
    unzip
    autoPatchelfHook
  ];
  buildInputs = [ stdenv.cc.cc.lib ];
  dontStrip = true;
  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -Dm755 agy_acp_server.par "$out/bin/agy_acp_server.par"
    install -Dm755 localharness_external "$out/bin/localharness_external"
    runHook postInstall
  '';

  meta = {
    description = "Google Antigravity ACP runtime";
    homepage = "https://antigravity.google/docs/ide/extensions";
    license = lib.licenses.unfree;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    mainProgram = "agy_acp_server.par";
  };
}
