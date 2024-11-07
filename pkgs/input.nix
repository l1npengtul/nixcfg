{pkgs, ...}: {
  environment.systemPackages = [pkgs.libwacom pkgs.input-remapper];
}
