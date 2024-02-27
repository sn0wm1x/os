{
  disko.devices = {
    disk.nvme0n1 = {
      type = "disk";
      device = "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "defaults" ];
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptroot";
              settings = {
                allowDiscards = true;
                bypassWorkqueues = true;
                keyFile = "/key/nixos.key";
                keyFileSize = 8192;
                preOpenCommands = ''
                  mkdir -m 0755 -p /key
                  sleep 2
                  mount -n -t vfat -o ro /dev/disk/by-id/${PRIMARYUSBID} /key || mount -n -t vfat -o ro /dev/disk/by-id/${BACKUPUSBID} /key
                ''
                postOpenCommands = ''
                  umount /key
                  rm -rf /key
                ''
                # sleep 5
                # until mount -n -t vfat -o ro /dev/disk/by-id/${PRIMARYUSBID} /key 2>&1 1>/dev/null; do
                #   echo 'Could not find /dev/disk/by-id/${PRIMARYUSBID}, retrying...'
                #   sleep 2
                # done
              };
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
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
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "defaults" "size=4G" "mode=755" "noatime" ];
    };
  };
  fileSystems."/persist".neededForBoot = true;
}
