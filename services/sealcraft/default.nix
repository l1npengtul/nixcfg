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
    servers.fabric = {
      enable = true;

      serverProperties = {
        difficulty = "hard";
        motd = "gooning expllicitly FORBIDDEN.";
        gamemode = "survival";
        level-name = "world";
        level-seed = "7919907699005295953";
        max-players = 20;
        white-list = true;
        view-distance = "10";
      };

      jvmOpts = "-Xms4096M -Xmx4096M --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20";

      # Specify the custom minecraft server package
      package = pkgs.fabricServers.fabric-1_21_4.override {
        loaderVersion = "0.16.10";
      }; # Specific fabric loader version

      symlinks = {
        mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
          Fabric-API = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/UnrycCWP/fabric-api-0.115.1%2B1.21.4.jar";
            hash = "sha256-r7bbPrB0Qhhlv3J3kIPMne3NtOVvqzFVD6VKAN/KkuU=";
          };
          FerriteCore = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/uXXizFIs/versions/IPM0JlHd/ferritecore-7.1.1-fabric.jar";
            hash = "";
          };
          Lithium = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/NHA11tBg/lithium-fabric-0.14.7%2Bmc1.21.1.jar";
            hash = "";
          };
          ModernFix = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/nmDcB62a/versions/ZGxQddYr/modernfix-fabric-5.20.3%2Bmc1.21.4.jar";
            hash = "";
          };
          C2ME = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/VSNURh3q/versions/Qgg5mpR6/c2me-fabric-mc1.21.4-0.3.2%2Balpha.0.33.jar";
            hash = "sha256-ejpGXyGpLY8K5N4JsjA4teH8ilbZdhKE2nm1XzfMHSc=";
          };
          Noisium = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/KuNKN7d2/versions/9NHdQfkN/noisium-fabric-2.5.0%2Bmc1.21.4.jar";
            hash = "";
          };
          HeadNameFix = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/rbU0dAND/versions/OdeNSZVg/head-name-fix-1.21.4-1.3.2.jar";
            hash = "";
          };
          NoChatReports = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/qQyHxfxd/versions/9xt05630/NoChatReports-FABRIC-1.21.4-v2.11.0.jar";
            hash = "sha256-1jMJbw5wL/PwsNSEHs4MHJpjyvPVhbhiP59dnXRQJwI=";
          };
          Tectonic = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/lWDHr9jE/versions/8uiKNgr3/tectonic-fabric-1.21.4-2.4.2.jar";
            hash = "";
          };
          Nullscape = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/LPjGiSO4/versions/dHJAVX8s/Nullscape_1.21.x_v1.2.10.jar";
            hash = "sha256-DaR0Vv8+o4Nd8B14qCjtuvryDc/tfXf6Ntg1T4dmys4=";
          };
          Ledger = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/LVN9ygNV/versions/a6TcvEKA/ledger-1.3.7.jar";
            hash = "";
          };
          Funny = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/p1WH6sHr/versions/4VXWFsMc/From-The-Fog-1.20.3-1.20.4-v1.9.3-Forge-Fabric.jar";
            hash = "sha256-HymUUVKyOZJvpsNDdlg2xMpg3X7zvK7Cnyf6tns1/L4=";
          };
        });
      };
    };
  };
  services.playit = {
    enable = true;
    user = "playit";
    group = "playit";
    secretPath = config.age.secrets.playit-secret.path;
  };
  environment.systemPackages = [pkgs.mcrcon];
}
