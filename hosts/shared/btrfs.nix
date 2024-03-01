{
  # https://nixos.wiki/wiki/Btrfs#Scrubbing
  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub.interval = "weekly";
  services.btrfs.autoScrub.fileSystems = [ "/persist" ];

  # bees
  services.beesd.filesystems = {
    persist = {
      spec = "/persist";
      hashTableSizeMB = 1024;
      verbosity = "crit";
      extraOptions = [ "--loadavg-target" "5.0" ];
    };
  };

  # TODO: https://github.com/kdave/btrfsmaintenance
}
