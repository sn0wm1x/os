{
  environment.persistence."/persist" = {
    hideMounts = true;
    # https://nixos.wiki/wiki/Impermanence#Persisting
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.kwa = {
      # https://github.com/nix-community/impermanence#home-manager
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        ".gnupg"
        ".ssh"
        ".nixops"
        ".local"
      ];
    };
  };
}
