{pkgs, ...}: {
  environment.systemPackages = [pkgs.kdePackages.kde-gtk-config];
}
