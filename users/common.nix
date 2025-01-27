{pkgs, ...}: {
  home.packages = with pkgs; [kdePackages.polkit-kde-agent-1 kdePackages.partitionmanager kdePackages.filelight kdePackages.kpmcore];
}
