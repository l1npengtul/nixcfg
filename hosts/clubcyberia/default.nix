{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./../common/userl1npengtul.nix
    ./../common/cpugpu.nix
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
    options = ["rw"];
  };
  networking.hostName = "clubcyberia";

  system.stateVersion = "24.11";
}
