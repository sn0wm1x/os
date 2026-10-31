{ pkgs, ... }:
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
    };
  };

  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp.override { cudaSupport = false; };
    settings = {
      model = "/persist/home/kwa/.cache/huggingface/hub/models--Qwen--Qwen3-Embedding-4B-GGUF/snapshots/f4602530db1d980e16da9d7d3a70294cf5c190be/Qwen3-Embedding-4B-Q4_K_M.gguf";
      embedding = true;
      pooling = "last";
      n-gpu-layers = 0;
      parallel = 8;
      ctx-size = 16384;
      batch-size = 2048;
      ubatch-size = 2048;
      threads = 16;
      host = "127.0.0.1";
      port = 11435;
    };
  };

  virtualisation.oci-containers.containers.hyperqwen = {
    image = "ghcr.io/syv-ai/hyperqwen:sha-f382342";
    cmd = [ "batch" ];
    ports = [ "127.0.0.1:18020:18020" ];
    volumes = [
      "/opt/hyperqwen/models:/app/models"
      "/opt/hyperqwen/cache:/cache"
    ];
    devices = [ "nvidia.com/gpu=0" ];
    environment = {
      HOME = "/cache";
      HOST = "0.0.0.0";
      VLLM_API_KEY = "correcthorsebatterystaple";
      KV = "fp8";
      MAX_LEN = "150000";
      INT8_LAYERS = ".";
      PREFIX_CACHE = "1";
      FAST_VARIANT = "0";
      DFLASH2 = "0";
    };
    extraOptions = [ "--ipc=host" ];
  };

  systemd.tmpfiles.rules = [
    "d /opt/hyperqwen/models 0750 root root -"
    "d /opt/hyperqwen/cache 0750 root root -"
  ];

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
