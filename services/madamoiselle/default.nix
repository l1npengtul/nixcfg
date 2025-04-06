{
  config,
  pkgs,
  ...
}: let
  package = pkgs.callPackage ./madamoiselle.nix {};
in {
  imports = [./service.nix];

  environment.systemPackages = [package];
  services.madamoiselle.enable = true;
}
