{pkgs, ...}: let
  bubbles = pkgs.callPackage ./bubbles.nix {};
  minibit = pkgs.callPackage ./minibit.nix {};
  moonecho = pkgs.callPackage ./moonecho.nix {};
  textures = pkgs.callPackage ./textures.nix {};
  lines = pkgs.callPackage ./lines.nix {};
  noises = pkgs.callPackage ./noises.nix {};
in {
  environment.systemPackages = [
    bubbles
    minibit
    moonecho
    textures
    lines
    noises
  ];
}
