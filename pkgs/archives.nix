{pkgs, ...}: {
  environment.systemPackages = [pkgs.kdePackages.ark pkgs.p7zip pkgs.unar];
}
