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
  ];

  home.sessionVariables = {
    AGENT_BROWSER_EXECUTABLE_PATH = lib.getExe pkgs.google-chrome;
  };

  home.persistence."/persist".directories = [
    ".codex"
    ".pi"
  ];
}
