{ pkgs, ... }: {
  # https://nixos.wiki/wiki/Discord#Vesktop
  home.packages = with pkgs; [
    (vesktop.overrideAttrs {
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/ve/vesktop/package.nix#L150-L161
      desktopItems = [
        (makeDesktopItem {
          name = "vesktop";
          desktopName = "Discord"; # original desktop name
          exec = "vesktop %U";
          icon = "discord"; # original icon
          startupWMClass = " Vesktop";
          genericName = "Internet Messenger";
          keywords = [ "discord" "vencord" "electron" "chat" ];
          categories = [ "Network" "InstantMessaging" "Chat" ];
        })
      ];
    })
  ];
  home.persistence."/persist/home/kwa".directories = [ ".config/vesktop" ];
}
