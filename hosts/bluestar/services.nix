{ inputs, pkgs, ... }: {
  services.ollama = {
    enable = true;
    package = inputs.sn0wm1x.packages.${pkgs.system}.ollama-sycl-bin;
    # sudo chown -R ollama:ollama /opt/ollama
    home = "/opt/ollama";
    user = "ollama";
    # group = "ollama";
  };
}
