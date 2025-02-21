{pkgs, ...}: {
  environment.systemPackages = [pkgs.samsung-unified-linux-driver];
  services.printing.enable = true;
}
