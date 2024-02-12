# kwaa/nixos [WIP]

```bash
# https://github.com/nix-community/disko/blob/master/docs/quickstart.md#step-4-copy-the-disk-configuration-to-your-machine
cd /tmp
curl https://raw.githubusercontent.com/kwaa/nixos/main/disko-config.nix -o /tmp/disko-config.nix
openssl rand -base64 18 > /tmp/secret.key # generate random password
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko-config.nix
nixos-generate-config --no-filesystems --root /mnt
mv /tmp/disko-config.nix /mnt/etc/nixos
nano /mnt/etc/nixos/configuration.nix
```

- https://nixos-and-flakes.thiscute.world/zh/nixos-with-flakes/nixos-with-flakes-enabled
- https://github.com/nix-community/disko/blob/master/docs/HowTo.md#installing-nixos-module

```bash
nixos-install
reboot
```

## Useful links

- https://github.com/nix-community/disko/blob/master/docs/quickstart.md
- https://github.com/Misterio77/nix-starter-configs/tree/main/minimal
