{pkgs, ...}: let
  bubbles = pkgs.callPackage ./bubbles.nix {};
  minibit = pkgs.callPackage ./minibit.nix {};
  moon-echo = pkgs.callPackage ./moon-echo.nix {};
  textures = pkgs.callPackage ./textures.nix {};
  lines = pkgs.callPackage ./lines.nix {};
  noises = pkgs.callPackage ./noises.nix {};
in {
  environment.systemPackages = [
    bubbles
    minibit
    moon-echo
    textures
    lines
    noises
  ];
}
