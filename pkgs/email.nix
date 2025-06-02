{pkgs, ...}: {
  programs.thunderbird.enable = true;
  services.protonmail-bridge.enable = true;
  environment.systemPackages = with pkgs; [birdtray];
}
