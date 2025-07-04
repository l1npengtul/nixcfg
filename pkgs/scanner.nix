{pkgs, ...}: {
  hardware.sane = {
    enable = true;
    extraBackends = with pkgs; [sane-airscan epkowa];
  };
  services.udev.packages = with pkgs; [sane-airscan epkowa];
  environment.systemPackages = with pkgs; [xsane kdePackages.skanpage kdePackages.skanpage];
}
