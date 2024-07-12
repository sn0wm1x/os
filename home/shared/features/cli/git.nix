{ pkgs, ... }: {
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

  # gh
  programs.gh.enable = true;
  programs.gh.extensions = with pkgs; [
    gh-collaborators
    # gh-dash
    gh-markdown-preview
    gh-notify
    gh-poi
  ];

  # gh-dash
  programs.gh-dash.enable = true;
  programs.gh-dash.catppuccin.enable = true;

  # lazygit
  programs.lazygit.enable = true;
  programs.lazygit.catppuccin.enable = true;
}
