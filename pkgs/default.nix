# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs:
let
  byName = builtins.readDir ./by-name;
  pkgsByName = builtins.mapAttrs (name: _: pkgs.callPackage (./by-name + "/${name}") { }) byName;
in
{
  # example = pkgs.callPackage ./example { };
} // pkgsByName
  
