{ pkgs, ... }: {
  # Firewall
  networking.firewall.enable = true;

  # SSH
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = false;

  # TODO: mosh

  # Proxychains
  programs.proxychains.enable = true;
  programs.proxychains.package = pkgs.proxychains-ng;
  programs.proxychains.quietMode = true;
  programs.proxychains.proxies = {
    naive = {
      enable = true;
      type = "socks5";
      host = "127.0.0.1";
      port = 10888;
    };
  };

  environment.shellAliases = {
    pc = "proxychains";
  };
}
