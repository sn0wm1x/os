{ config, lib, ... }: {
  xdg.enable = true;

  # mime
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;

  # user-dirs
  xdg.configFile."user-dirs.locale".text = lib.mkForce "en_US";
  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;
  xdg.userDirs.music = "${config.home.homeDirectory}/Music";
  xdg.userDirs.videos = "${config.home.homeDirectory}/Videos";
  xdg.userDirs.pictures = "${config.home.homeDirectory}/Pictures";
  xdg.userDirs.desktop = "${config.home.homeDirectory}/Desktop";
  xdg.userDirs.download = "${config.home.homeDirectory}/Download";
  xdg.userDirs.templates = "${config.home.homeDirectory}/Templates";
  xdg.userDirs.documents = "${config.home.homeDirectory}/Documents";
}
