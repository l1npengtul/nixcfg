{pkgs-stable, ...}:

{

    flux = {
        enable = true;
        servers = {
            sealcraft = {
                package = pkgs-stable.mkMinecraftServer {
                    name = "sealcraft";
                    src = ./sealcraft_config;
                    hash = "";
                };
                proxy.enable = true;
                proxy.backend = "playit";
            };
        };
    };
}
