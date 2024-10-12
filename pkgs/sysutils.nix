{pkgs, ...}: {
  environment.systemPackages = [pkgs.dpkg pkgs.binutils pkgs.upx];
}
