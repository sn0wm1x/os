{ lib, ... }: {
  # https://github.com/chuangzhu/nixpkgs-gnome-mobile#do-input-methods-work
  dconf.settings."org/gnome/desktop/input-sources".sources = with lib.hm.gvariant; [
    (mkTuple [ "xkb" "us" ])
    (mkTuple [ "ibus" "libpinyin" ])
    (mkTuple [ "ibus" "mozc" ])
  ];
}
