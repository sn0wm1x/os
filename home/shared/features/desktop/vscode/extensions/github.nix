{ pkgs, ... }:
{
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      github.vscode-pull-request-github
      github.vscode-github-actions
    ];
    userSettings = {
      "githubIssues.workingIssueFormatScm" = "#\${issueNumberLabel}";
      "githubPullRequests.fileListLayout" = "tree";
    };
  };
}
