{
  # git
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.git.userName = "藍+85CD";
  programs.git.userEmail = "50108258+kwaa@users.noreply.github.com";
  programs.git.extraConfig = {
    init.defaultBranch = "main";
    # safe.directory = [];
  };

  # gh
  programs.gh.enable = true;

  # lazygit
  programs.lazygit.enable = true;
}
