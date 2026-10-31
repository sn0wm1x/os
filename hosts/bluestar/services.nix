{
  config,
  lib,
  pkgs,
  ...
}:
{
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
      # Both servers share the model store; avoid startup pruning across instances.
      OLLAMA_NOPRUNE = "1";
    };
  };

  systemd.services.ollama-cpu = {
    description = "Ollama CPU-only server";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    environment = {
      HOME = config.services.ollama.home;
      OLLAMA_MODELS = config.services.ollama.modelsDir;
      OLLAMA_HOST = "127.0.0.1:11435";
      CUDA_VISIBLE_DEVICES = "-1";
      OLLAMA_CONTEXT_LENGTH = "32768"; # 32K
      OLLAMA_ORIGINS = "*";
      OLLAMA_NOPRUNE = "1";
    };
    serviceConfig = {
      Type = "exec";
      User = config.services.ollama.user;
      Group = config.services.ollama.group;
      WorkingDirectory = config.services.ollama.home;
      ExecStart = "${lib.getExe config.services.ollama.package} serve";
      Restart = "on-failure";
    };
  };

  # virtualisation.oci-containers.containers.strata = {
  #   image = "ghcr.io/niko1221/strata:0.2.8-cuda13";
  #   ports = [ "127.0.0.1:11535:8080" ];
  #   volumes = [ "/opt/strata:/data" ];
  #   devices = [ "nvidia.com/gpu=0" ];
  #   environment = {
  #     API_KEY = "correcthorsebatterystaple";
  #     FAMILY = "qwen";
  #     MODEL = "IQ2_XS";
  #     CONTEXT = "256k";
  #     PARALLEL = "4";
  #     VISION = "cpu";
  #     KV = "int8";
  #     STRATA_SET = "kv-resident=32768 batch-mtp=on spec=4 adapt-async=1 pool-affinity=measure";
  #     TUNE = "quick";
  #   };
  #   extraOptions = [
  #     "--ulimit=memlock=-1:-1"
  #     "--shm-size=2g"
  #     "--stop-timeout=120"
  #   ];
  # };

  # systemd.tmpfiles.rules = [ "d /opt/strata 0750 root root -" ];
  # systemd.services.docker-strata.serviceConfig.Restart = lib.mkForce "always";
}
