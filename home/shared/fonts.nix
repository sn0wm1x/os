{ pkgs, ... }: {
  # https://nixos.wiki/wiki/Fonts
  # fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts
    # noto-fonts-cjk
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    noto-fonts-emoji
    # monaspace
    (nerdfonts.override { fonts = [
      "Monaspace"
    ]; })
  ];
  fonts.fontconfig.defaultFonts = {
    sansSerif = [
      "Noto Sans"
      "Noto Sans CJK SC"
      "Noto Color Emoji"
      "Noto Emoji"
    ];
    serif = [
      "Noto Serif"
      "Noto Serif CJK SC"
      "Noto Color Emoji"
      "Noto Emoji"
    ];
    monospace= [
      "MonaspiceNe Nerd Font Mono"
      "Noto Sans Mono"
      "Noto Sans Mono CJK SC"
      "Noto Color Emoji"
      "Noto Emoji"
    ];
  };
}
