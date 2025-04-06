{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./../common/userl1npengtul.nix
  ];

  time.timeZone = "Asia/Tokyo";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 48 * 1024;
    }
  ];

  fileSystems."/home/l1npengtul/hdd_files" = {
    option = ["rw"];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  networking.hostName = "clubcyberia";

  musnix.enable = true;
  musnix.rtcqs.enable = true;

  system.stateVersion = "24.11";
}
