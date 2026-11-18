{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    home = "/opt/ollama";
    user = "ollama";
    environmentVariables = {
      OLLAMA_ORIGINS = "*";
      OLLAMA_CONTEXT_LENGTH = "131072"; # 128K
      # OLLAMA_FLASH_ATTENTION = "1";
      OLLAMA_KV_CACHE_TYPE = "q8_0";
    };
  };

  users.groups.ravu = { };
  users.users.ravu = {
    isSystemUser = true;
    group = "ravu";
    home = "/opt/ravu";
    extraGroups = [ "docker" ];
  };
  systemd.tmpfiles.rules = [
    "d /opt/ravu 2770 ravu docker -"
    "d /opt/ravu/bin 2770 ravu docker -"
    "d /opt/ravu/data 2770 ravu docker -"
  ];
  # The binary at /opt/ravu/bin/ravu is not built here; without it the service is skipped.
  systemd.services.ravu = {
    description = "RAVU";
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [
      "network-online.target"
      "ollama.service"
    ];
    path = with pkgs; [
      docker
      git
    ];
    environment = {
      HOME = "/opt/ravu";
      RAVU_HOME = "/opt/ravu/data";
    };
    unitConfig.ConditionPathExists = "/opt/ravu/bin/ravu";
    serviceConfig = {
      ExecStart = "/opt/ravu/bin/ravu serve";
      Group = "docker";
      Restart = "on-failure";
      RestartSec = 5;
      UMask = "0007";
      User = "ravu";
      WorkingDirectory = "/opt/ravu";
    };
  };
  # Containers cannot reach the local network or this host.
  networking.nftables.tables.docker-isolation = {
    family = "inet";
    content = ''
      chain forward {
        type filter hook forward priority filter - 1; policy accept;
        iifname "docker0" ip daddr 10.0.0.0/8 drop
      }
      chain input {
        type filter hook input priority filter - 1; policy accept;
        iifname "docker0" ct state new drop
      }
    '';
  };
}
