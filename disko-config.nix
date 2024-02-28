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
                # https://nixos.wiki/wiki/Full_Disk_Encryption#Option_2:_Copy_Key_as_file_onto_a_vfat_usb_stick
                # https://github.com/reo101/rix101/blob/a6efd4146bbe0c7fb44343225b9dbf9585472597/machines/nixos/x86_64-linux/jeeves/disko.nix#L94-L107
                preOpenCommands = ''
                  mkdir -m 0755 -p /key
                  sleep 2
                  until mount -n -t vfat -o ro /dev/disk/by-id/${USBID} /key 2>&1 1>/dev/null; do
                    echo 'Could not find /dev/disk/by-id/${USBID}, retrying...'
                    sleep 2
                  done
                '';
                postOpenCommands = ''
                  umount /key
                  rm -rf /key
                '';
                # mount -n -t vfat -o ro /dev/disk/by-id/${PRIMARYUSBID} /key || mount -n -t vfat -o ro /dev/disk/by-id/${BACKUPUSBID} /key
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
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [ "defaults" "size=2G" "mode=755" "noatime" ];
      };
      "/home/kwa" = {
        fsType = "tmpfs";
        mountOptions = [ "defaults" "size=2G" "mode=777" "noatime" ];
      }
    };
  };
  fileSystems."/persist".neededForBoot = true;
}
