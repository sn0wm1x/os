{ pkgs, ... }:
{
  home.packages = with pkgs.llm-agents; [ gemini-cli ];

  home.persistence."/persist".directories = [
    ".gemini"
  ];
}
