{ pkgs, ... }: {
  home.packages = with pkgs; [ deno ];
  home.persistence."/persist/home/kwa".directories = [ ".cache/deno" ];
}