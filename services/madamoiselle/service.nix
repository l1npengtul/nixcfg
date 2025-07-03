{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.services.madamoiselle;
  madamoiselle = pkgs.callPackage ./madamoiselle.nix {};
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
        StateDirectory = "madamoiselle";
        RuntimeDirectory = "/var/lib/madamoiselle";
        RuntimeDirectoryMode = "0777";
        Environment = "RUST_LOG=info";
        SyslogLevel = "info";
        ExecStart = "${madamoiselle}/bin/madamoiselle";
      };
    };
    environment.systemPackages = [madamoiselle];
  };
}
