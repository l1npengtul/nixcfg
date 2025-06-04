{pkgs, ...}: {
  home.packages = with pkgs; [kdePackages.kcharselect kdePackages.kcharselect kdePackages.kompare kdePackages.yakuake];
}
