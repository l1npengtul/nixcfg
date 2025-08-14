{pkgs, ...}: {
  home.packages = with pkgs; [kdePackages.polkit-kde-agent-1 kdePackages.partitionmanager kdePackages.filelight kdePackages.kpmcore kdePackages.karousel];

  xdg.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
  xdg.portal.config.common.default = "kde";

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  systemd.user.services.polkit-kde-authentication-agent-1 = {
    Unit = {
      Description = "polkit-kde-authentication-agent-1";
      Wants = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
