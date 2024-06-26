# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
}
# by-name
# // builtins.mapAttrs (name: _: pkgs.callPackage (./by-name + "/${name}") { }) (builtins.readDir ./by-name)
