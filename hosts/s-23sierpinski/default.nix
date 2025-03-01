{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./../common/use-remote.nix
    ./../common/battery_optimizations.nix
    ./../common/userl1npengtul.nix
  ];
  time.timeZone = "Asia/Tokyo";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.graphics = {
    # hardware.opengl in 24.05
    enable = true;
    enable32Bit = true; # driSupport32Bit in 24.05
    extraPackages = with pkgs; [
      intel-compute-runtime
      vpl-gpu-rt
    ];
  };

  networking.hostName = "s-23sierpinski"; # Define your hostname.

  system.stateVersion = "24.11";
}
