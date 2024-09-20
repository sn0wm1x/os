{ pkgs, ... }: {
  # https://github.com/chuangzhu/nixpkgs-gnome-mobile/#do-input-methods-work
  i18n.inputMethod.enable = true;
  i18n.inputMethod.type = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [
    libpinyin
    mozc
  ];
}
