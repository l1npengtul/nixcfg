{pkgs, ...}: {
  environment.systemPackages = [pkgs.dpkg pkgs.binutils pkgs.upx pkgs.tmux pkgs.popsicle pkgs.hyfetch pkgs.zenith pkgs.onefetch pkgs.exfat pkgs.exfatprogs pkgs.xfsprogs pkgs.f3 pkgs.mesa-demos pkgs.freshfetch pkgs.micro-full];
}
