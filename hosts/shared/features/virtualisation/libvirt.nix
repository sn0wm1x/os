{ pkgs, ... }: {
  # https://nixos.wiki/wiki/Libvirt
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;

  # https://nixos.wiki/wiki/Virt-manager
  programs.virt-manager.enable = true;
}
