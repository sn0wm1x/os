{ pkgs, ... }: {
  home.packages = with pkgs; [ antigravity ];
  home.persistence."/persist".directories = [ ".config/antigravity" ];
}
