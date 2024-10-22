# https://github.com/ryan4yin/nix-config/blob/main/Justfile

# use nushell for shell commands
set shell := ["nu", "-c"]

hostname := `cat /etc/hostname`

# show available recipes.
list:
  @just --list

rebuild:
  nh os switch --ask .

build package *args='':
  nom build .#{{package}} {{args}}

nixos-rebuild mode='switch' *args='':
  sudo nixos-rebuild {{mode}} --flake .#{{hostname}} {{args}}

build-mobile target='enchilada':
  nom build .#nixosConfigurations.{{target}}.config.mobile.outputs.android.android-fastboot-images

up:
  nix flake update

# Update specific input
# Usage: just upp nixpkgs
upp input:
  nix flake lock --update-input {{input}}

history:
  nix profile history --profile /nix/var/nix/profiles/system

repl:
  nix repl -f flake:nixpkgs

clean:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

gc:
  # garbage collect all unused nix store entries
  sudo nix store gc --debug
  sudo nix-collect-garbage --delete-old

gitgc:
  git reflog expire --expire-unreachable=now --all
  git gc --prune=now

fmt:
  # format the nix files in this repo
  nix fmt