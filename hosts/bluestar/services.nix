{ inputs, pkgs, ... }: {
  services.ollama = {
    enable = true;
    package = inputs.sn0wm1x.packages.${pkgs.system}.ollama-sycl-bin;
    # sudo mkdir /opt/ollama
    # sudo chown -R ollama:ollama /opt/ollama
    home = "/opt/ollama";
    user = "ollama";
    # group = "ollama";
    environmentVariables = {
      OLLAMA_DEBUG = "1";
      OLLAMA_INTEL_GPU = "1";
      # sudo mkdir /opt/ollama/tmp
      OLLAMA_TMPDIR = "/opt/ollama/tmp/";
    };
  };
}
