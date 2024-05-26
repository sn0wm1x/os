{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nil
    nixpkgs-fmt
  ];
}
