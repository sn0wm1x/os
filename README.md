# kwaa/nixos [WIP]

## Usage

###### Setup Cryptkey

```bash
sudo mkdir -p /key
lsblk && ls -l /dev/disk/by-id
sudo mount -n -t vfat -o rw /dev/disk/by-id/usb-Acer_USB_Flash_Drive_2235079219404-0:0-part1 /key
sudo dd if=/dev/random of=/key/nixos.key bs=8192 count=1
```

###### Partition & Format & Mount

```bash
cd /tmp
curl https://raw.githubusercontent.com/kwaa/nixos/main/hosts/bluestar/disko.nix -o /tmp/disko.nix
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix
```

###### Install

```bash
cd /etc
sudo nix --experimental-features "nix-command flakes" run nixpkgs#git -- clone https://github.com/kwaa/nixos.git
cd nixos
NIX_CONFIG="experimental-features = nix-command flakes" sudo nixos-install --flake .#bluestar --no-root-passwd
sudo chmod -v 755 /mnt/etc/nixos
reboot
```

## Useful links

- https://github.com/nix-community/disko/blob/master/docs/quickstart.md
- https://github.com/Misterio77/nix-starter-configs/tree/main/minimal
