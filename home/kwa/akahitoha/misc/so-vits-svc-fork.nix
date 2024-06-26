{ outputs, pkgs, ... }: {
  home.packages = with outputs.packages."${pkgs.system}"; [
    so-vits-svc-fork
  ];
}
