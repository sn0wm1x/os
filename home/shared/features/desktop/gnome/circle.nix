{ pkgs, ... }:
{
  # GNOME Circle Apps
  # https://circle.gnome.org/
  # https://github.com/NixOS/nixpkgs/issues/195280
  home.packages = with pkgs; [
    # collision
    eyedropper
    gnome-frog # OCR
  ];
}
