{
  config,
  pkgs,
  lib,
  callPackage,
  ...
}: let
  cfg = config.services.madamoiselle;
  madamoiselle = import ./madamoiselle.nix {};
  madamoiselle-pkg = callPackage ./madamoiselle.nix {};
in {
  options = {
    services.madamoiselle = {
      enable = lib.mkEnableOption "enable madamoiselle";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.madamoiselle = {
      wantedBy = ["default.target"];
      after = ["network.target"];
      description = "enable madamoiselle discord bot";
      serviceConfig = {
        StateDirectory = "foo";
        StateDirectoryMode = "0777";
        ExecStart = "${madamoiselle}/bin/madamoiselle";
      };
    };
  };

  environment.systemPackages = [madamoiselle-pkg];
}
