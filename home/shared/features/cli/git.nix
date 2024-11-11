{ pkgs, ... }:
{
  # git
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.git.extraConfig = {
    init.defaultBranch = "main";
    # safe.directory = [];
  };

  # difftastic
  # TODO: difftastic + magit (emacs)
  programs.git.difftastic.enable = true;

  # TODO: mergiraf
  # https://github.com/NixOS/nixpkgs/pull/354870

  # gitui
  programs.gitui.enable = true;
  programs.gitui.catppuccin.enable = true;

  # gh
  programs.gh.enable = true;
  programs.gh.extensions = with pkgs; [
    # gh-dash
    gh-markdown-preview
    gh-notify
    gh-poi
  ];

  # gh-dash
  programs.gh-dash.enable = true;
  programs.gh-dash.catppuccin.enable = true;
}
