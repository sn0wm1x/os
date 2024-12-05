{ pkgs, ... }:
{
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
    material-symbols
    material-design-icons
    font-awesome
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
}
