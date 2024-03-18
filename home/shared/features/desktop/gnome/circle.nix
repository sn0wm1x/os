{pkgs, ...}: {
  # GNOME Circle Apps
  # https://circle.gnome.org/
  home.packages = with pkgs; [
    # collision
    eyedropper
  ];
}
