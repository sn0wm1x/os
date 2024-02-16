{
  disko.devices = {
    disk = {
      nvme0n1 = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";
                settings.allowDiscards = true;
                settings.bypassWorkqueues = true;
                settings.crypttabExtraOpts = [ "fido2-device=auto" "token-timeout=10" ];
                # disable settings.keyFile if you want to use interactive password entry
                passwordFile = "/tmp/secret.key"; # Interactive
                # settings = {
                #   allowDiscards = true;
                #   keyFile = "/tmp/secret.key";
                # };
                # additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    # "/root" = {
                    #   mountpoint = "/";
                    #   mountOptions = [ "compress-force=zstd:1" "noatime" ];
                    # };
                    # "/home" = {
                    #   mountpoint = "/home";
                    #   mountOptions = [ "compress-force=zstd:1" "noatime" ];
                    # };
                    "/persist" = {
                      mountpoint = "/persist";
                      mountOptions = [ "compress-force=zstd:1" "noatime" ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress-force=zstd:1" "noatime" ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [ "defaults" "size=4G" "mode=755" ];
      };
    };
  };

  fileSystems."/persist".neededForBoot = true;
}
