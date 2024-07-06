{
  # Firewall
  networking.firewall.enable = true;

  # SSH
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = false;

  # TODO: mosh
}
