{pkgs, ...}: {
  home.packages = with pkgs; [kdePackages.polkit-kde-agent-1 kdePackages.partitionmanager kdePackages.filelight kdePackages.kpmcore];
  xdg.enable = true;
  services.home-manager.autoExpire.enable = true;
  services.home-manager.autoExpire.frequency = "weekly";
  services.home-manager.autoExpire.timestamp = "-7 days";
}
