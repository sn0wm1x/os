{
  config,
  pkgs,
  lib,
  ...
}:
let
  claude-code-wrapped =
    pkgs.runCommand "claude-code-wrapped"
      {
        nativeBuildInputs = [ pkgs.makeWrapper ];

        meta = pkgs.llm-agents.claude-code.meta // {
          mainProgram = "claude";
        };

        passthru.unwrapped = pkgs.llm-agents.claude-code;
      }
      ''
        mkdir -p "$out/bin"

        makeWrapper ${lib.getExe pkgs.llm-agents.claude-code} "$out/bin/claude" \
          \
          --set TZ "Etc/UTC" \
          --set LANG "en_US.UTF-8" \
          --set LC_ALL "en_US.UTF-8" \
          --set LANGUAGE "en_US:en" \
          --set HOSTNAME "linux" \
          \
          --set DISABLE_TELEMETRY "1" \
          --set DO_NOT_TRACK "1" \
          --set DISABLE_UPDATES "1" \
          --set DISABLE_ERROR_REPORTING "1" \
          --set DISABLE_FEEDBACK_COMMAND "1" \
          --set DISABLE_GROWTHBOOK "1" \
          --set CLAUDE_CODE_DISABLE_FEEDBACK_SURVEY "1" \
          --set CLAUDE_CODE_ENABLE_TELEMETRY "0" \
          --set CLAUDE_CODE_GATEWAY_HINT_HEADERS "0" \
          --set CLAUDE_CODE_ATTRIBUTION_HEADER "0"
      '';
in
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

  programs.claude-code = {
    enable = true;
    # package = pkgs.llm-agents.claude-code;
    package = claude-code-wrapped;
  };

  programs.opencode = {
    enable = true;
    package = pkgs.llm-agents.opencode;
    tui.theme = "system";
    enableMcpIntegration = true;
    web.enable = true;
  };

  home.packages =
    (with pkgs.llm-agents; [
      ccusage
      # rtk
      chatgpt
      dsh
      opencodex
      pi
      agent-browser
    ])
    ++ (with pkgs; [
      devin-cli
    ]);

  home.sessionVariables = {
    AGENT_BROWSER_EXECUTABLE_PATH = lib.getExe pkgs.google-chrome;

    DSH_HOME = "${config.xdg.stateHome}/dsh";
    OPENCODEX_HOME = "${config.xdg.stateHome}/opencodex";
  };

  home.persistence."/persist".directories = [
    ".codex"
    ".config/Codex" # chatgpt

    ".claude"

    ".pi"

    ".local/state/dsh"
    ".local/state/opencodex"

    ".config/devin"
    ".local/share/devin"
  ];
}
