{ lib, pkgs, ... }: {
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    # sudo chown -R ollama:ollama /opt/ollama
    home = "/opt/ollama";
    user = "ollama";
    environmentVariables = {
      OLLAMA_ORIGINS = "*";
      OLLAMA_CONTEXT_LENGTH = "131072"; # 128K
      OLLAMA_FLASH_ATTENTION = "1";
      OLLAMA_KV_CACHE_TYPE = "q8_0";
    };
  };

  virtualisation.oci-containers.containers.strata = {
    image = "ghcr.io/niko1221/strata:0.2.8-cuda13";
    ports = [ "127.0.0.1:8080:8080" ];
    volumes = [ "/opt/strata:/data" ];
    devices = [ "nvidia.com/gpu=0" ];
    environment = {
      FAMILY = "qwen";
      MODEL = "IQ2_XS";
      CONTEXT = "256k";
      PARALLEL = "4";
      VISION = "cpu";
      KV = "int8";
      STRATA_SET = "kv-resident=32768 batch-mtp=on spec=4 adapt-async=1 pool-affinity=measure";
      TUNE = "quick";
    };
    extraOptions = [
      "--ulimit=memlock=-1:-1"
      "--shm-size=2g"
      "--stop-timeout=120"
    ];
  };

  systemd.tmpfiles.rules = [ "d /opt/strata 0750 root root -" ];
  systemd.services.docker-strata.serviceConfig.Restart = lib.mkForce "always";
}
