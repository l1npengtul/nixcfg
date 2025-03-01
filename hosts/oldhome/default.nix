{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./../common/use-remote.nix
    ./../common/userl1npengtul.nix
    ./../common/battery_optimizations.nix
  ];

  time.timeZone = "Asia/Tokyo";

  boot.kernelParams = ["mem_sleep_default=deep"];
  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-label/MAGPIE_SIGNAL";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.hardware.bolt.enable = true;

  hardware.ipu6 = {
    enable = false;
    platform = "ipu6epmtl";
  };
  hardware.graphics = {
    # hardware.opengl in 24.05
    enable = true;
    enable32Bit = true; # driSupport32Bit in 24.05
    extraPackages = with pkgs; [
      intel-compute-runtime
      vpl-gpu-rt
    ];
  };

  networking.hostName = "oldhome"; # Define your hostname.

  musnix.enable = true;
  musnix.rtcqs.enable = true;

  system.stateVersion = "24.05";
}
