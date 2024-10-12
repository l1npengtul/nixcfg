{pkgs, ...}: {
  environment.systemPackages = [pkgs.jdk8 pkgs.jdk11 pkgs.jdk17 pkgs.jdk21 pkgs.zulu17];
}
