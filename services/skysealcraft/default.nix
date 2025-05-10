{
  config,
  pkgs,
  lib,
  ...
}: {
  # Minecraft server settings
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    managementSystem = {
      tmux.enable = false;
      systemd-socket.enable = true;
    };
    servers.fabric = {
      enable = true;

      serverProperties = {
        difficulty = "hard";
        motd = "gooning only allowed in the void";
        gamemode = "survival";
        level-name = "world";
        level-seed = "2152152151263";
        max-players = 20;
        white-list = true;
        view-distance = "8";
        sync-chunk-writes = false;
        max-chained-neighbor-updates = 10000;
        enable-rcon = true;
        "rcon.password" = "sealcraft";
      };

      jvmOpts = "-Xms6000M -Xmx6000M --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20";

      # Specify the custom minecraft server package
      package = pkgs.fabricServers.fabric-1_20_1.override {
        loaderVersion = "0.16.14";
        jre_headless = pkgs.temurin-jre-bin-23;
      }; # Specific fabric loader version

      symlinks = {
        mods =
          pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
            });
      };
    };
  };

  flux = {
    enable = true;
    servers.server-proxy = {
      package = pkgs.wget;
      proxy = {
        enable = true;
        backend = "playit";
      };
    };
  };
  #  services.playit = {
  #    enable = true;
  #    user = "playit";
  #    group = "playit";
  #    secretPath = config.age.secrets.playit-secret.path;
  #  };
  environment.systemPackages = [pkgs.mcrcon];
}
