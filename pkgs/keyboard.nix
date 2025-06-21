{pkgs, ...}: {
  environment.systemPackages = with pkgs; [via vial];
  services.udev.packages = with pkgs; [via vial];
}
