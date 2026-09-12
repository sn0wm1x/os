{
  config,
  pkgs,
  lib,
  ...
}:
{
  # https://home-manager-options.extranix.com/?query=codex&release=master
  programs.codex = {
    enable = true;
    package = pkgs.llm-agents.codex;
    # settings = {
    #   model = "gpt-oss";
    #   model_provider = "ollama";
    #   approval_policy = "untrusted";
    #   sandbox_mode = "workspace-write";
    # };
  };

  programs.opencode = {
    enable = true;
    package = pkgs.llm-agents.opencode;
    tui.theme = "system";
    enableMcpIntegration = true;
    web.enable = true;
  };

  home.packages = with pkgs.llm-agents; [
    ccusage
    # rtk
    pi
    agent-browser
    multica
  ];

  systemd.user.services.multica-daemon = {
    Unit = {
      Description = "Multica agent daemon";
      Documentation = [ "https://github.com/multica-ai/multica/blob/main/CLI_AND_DAEMON.md" ];
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      # systemd must supervise the foreground form; the default command
      # backgrounds itself and would make the unit appear to have exited.
      ExecStart = "${lib.getExe pkgs.llm-agents.multica} daemon start --foreground";
      Environment = [
        "PATH=${config.home.profileDirectory}/bin"
        # Use the hosted Multica backend instead of the local development default.
        "MULTICA_SERVER_URL=https://api.multica.ai"
        # Keep the binary managed by Nix/Home Manager.
        "MULTICA_DAEMON_AUTO_UPDATE=0"
      ];
      Restart = "on-failure";
      RestartSec = "5s";
    };

    Install.WantedBy = [ "default.target" ];
  };

  home.sessionVariables = {
    AGENT_BROWSER_EXECUTABLE_PATH = lib.getExe pkgs.google-chrome;
  };

  home.persistence."/persist".directories = [
    ".codex"
    ".multica"
    ".pi"
  ];
}
