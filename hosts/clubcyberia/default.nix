{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./../common/userl1npengtul.nix
  ];

  time.timeZone = "Asia/Tokyo";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  swapDevices = [
    {
      device = "/var/lib/swap/swapfile";
      size = 32 * 1024;
    }
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  networking.hostName = "clubcyberia";

  musnix.enable = true;
  musnix.rtcqs.enable = true;

  system.stateVersion = "24.11";
}
