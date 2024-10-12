{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      thunderbird
      protonmail-bridge
      birdtray
    ];
  };
  # Protonmail-Bridge service
  systemd.user.services.protonmail-bridge = {
    Unit = {
      Description = "Protonmail SMTP/IMAP client";
      Wants = "network-online.target";
      After = "network-online.target";
    };

    Service = {
      Type = "simple";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 3";
      ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive";
      Restart = "always";
    };

    Install.WantedBy = ["default.target"];
  };

  xdg.configFile."protonmail/bridge-v3/keychain.json".text = ''
    {
      "Helper": "secret-service-dbus"
    }
  '';
}
