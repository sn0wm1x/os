{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}:
let
  cfg = config.sn0wm1x.baseline-desktop;
in
{
  imports = [ inputs.catppuccin.nixosModules.catppuccin ];

  options.sn0wm1x.baseline-desktop = {
    enable = lib.mkEnableOption "SN0WM1X baseline-desktop configurations";
  };

  config = lib.mkIf cfg.enable {
    environment = {
      # https://nixos.wiki/wiki/Chromium#Enabling_native_Wayland_support
      sessionVariables.NIXOS_OZONE_WL = "1";

      systemPackages = with pkgs; [
        # alternative for steam-run (umu-run)
        # TODO: move to baseline?
        umu-launcher
      ];
    };

    xdg.portal = {
      enable = true;
      # xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
    };

    # https://wiki.nixos.org/wiki/PipeWire
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      # alsa.support32Bit = true;
      pulse.enable = true;
      # jack.enable = true;
    };

    i18n = {
      defaultLocale = lib.mkDefault "zh_CN.UTF-8";
      supportedLocales = lib.mkDefault [
        "en_US.UTF-8/UTF-8"
        "zh_CN.UTF-8/UTF-8"
        "zh_TW.UTF-8/UTF-8"
        "ja_JP.UTF-8/UTF-8"
      ];

      # https://wiki.nixos.org/wiki/Fcitx5
      inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5.addons = with pkgs; [
          fcitx5-mozc # Japanese
          fcitx5-chinese-addons # Chinese
          fcitx5-pinyin-zhwiki
          fcitx5-pinyin-moegirl
        ];
      };
    };

    environment.sessionVariables = {
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
    };

    # https://nixos.wiki/wiki/Fonts
    fonts.fontDir.enable = true;
    fonts.packages = with pkgs; [
      noto-fonts
      # noto-fonts-extra
      # noto-fonts-cjk
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      # monospace
      monaspace
      nerd-fonts.symbols-only
      nerd-fonts.monaspace
      # emoji / icon
      noto-fonts-color-emoji
      noto-fonts-emoji
      # material-symbols
      # material-design-icons
      # font-awesome
    ];
    fonts.fontconfig.defaultFonts = {
      sansSerif = [
        "Noto Sans"
        "Noto Sans CJK SC"
        "Noto Sans CJK TC"
        "Noto Sans CJK JP"
        "Noto Color Emoji"
        "Noto Emoji"
      ];
      serif = [
        "Noto Serif"
        "Noto Serif CJK SC"
        "Noto Serif CJK TC"
        "Noto Serif CJK JP"
        "Noto Color Emoji"
        "Noto Emoji"
      ];
      monospace = [
        "MonaspiceNe Nerd Font Mono"
        "Noto Sans Mono"
        "Noto Sans Mono CJK SC"
        "Noto Sans Mono CJK TC"
        "Noto Sans Mono CJK JP"
        "Noto Color Emoji"
        "Noto Emoji"
      ];
      emoji = [
        "Noto Color Emoji"
        "Noto Emoji"
      ];
    };

    # catppuccin/nix
    # https://nix.catppuccin.com/options/nixos-options.html
    catppuccin = {
      flavor = "frappe";
      accent = "blue";
    };

    home-manager = {
      sharedModules = [ outputs.homeManagerModules.baseline-desktop ];
      users.kwa.sn0wm1x.baseline-desktop.enable = true;
    };
  };
}
