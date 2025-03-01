{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./../common/userl1npengtu.nix
  ];

  time.timeZone = "Asia/Seoul";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems."/home/l1npengtul/project" = {
    device = "/dev/disk/by-uuid/125413e8-0b7a-464f-9d83-fa4e00f00a35";
    fsType = "ext4";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  networking.hostName = "pegrose512";

  musnix.enable = true;
  musnix.rtcqs.enable = true;

  system.stateVersion = "24.11";
}
