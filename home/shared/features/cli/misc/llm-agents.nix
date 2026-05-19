{ pkgs, ... }:
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

  # https://home-manager-options.extranix.com/?query=claude-code&release=master
  programs.claude-code = {
    enable = true;
    package = pkgs.llm-agents.claude-code;
    settings.theme = "dark";
    # mcpServers = {
    #   grep = {
    #     type = "http";
    #     url = "https://mcp.grep.app";
    #   };
    # };
  };

  home.packages = with pkgs.llm-agents; [
    ccusage-codex
    # rtk
    pi
  ];

  home.persistence."/persist".directories = [
    ".codex"
    ".pi"
  ];
}
