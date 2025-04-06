{
  config,
  callPackage,
  ...
}: let
  service = import ./service.nix {};
  package = callPackage ./madamoiselle.nix {};
in {
  environment.systemPackages = [package];
  config.services.madamoiselle.enable = true;
}
