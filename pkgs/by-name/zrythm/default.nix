{
  appimageTools,
  fetchurl,
  lib,
}:

let
  pname = "zrythm";
  version = "2.0.0-alpha.2";

  src = fetchurl {
    url = "https://github.com/zrythm/zrythm/releases/download/v${version}/Zrythm-${version}-Linux.AppImage";
    hash = "sha256-2pJG8uWxcXdHXHkqm1JA7MVKQIgQClUdcJL7Jq7npTw=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -Dm444 ${appimageContents}/share/applications/org.zrythm.Zrythm.desktop \
      -t $out/share/applications
    install -Dm444 ${appimageContents}/share/icons/hicolor/scalable/apps/org.zrythm.Zrythm.svg \
      -t $out/share/icons/hicolor/scalable/apps
    install -Dm444 ${appimageContents}/share/metainfo/org.zrythm.Zrythm.appdata.xml \
      -t $out/share/metainfo
    install -Dm444 ${appimageContents}/share/mime/packages/org.zrythm.Zrythm-mime.xml \
      -t $out/share/mime/packages
    install -Dm444 ${appimageContents}/share/man/zrythm.1 \
      -t $out/share/man/man1
  '';

  meta = {
    description = "Highly automated and intuitive digital audio workstation";
    homepage = "https://www.zrythm.org";
    changelog = "https://github.com/zrythm/zrythm/releases/tag/v${version}";
    license = lib.licenses.agpl3Plus;
    mainProgram = "zrythm";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [ kwaa ];
  };
}
