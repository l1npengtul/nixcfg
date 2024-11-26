{pkgs, ...}: {
  environment.systemPackages = [pkgs.pv pkgs.sox pkgs.flac pkgs.ffmpeg pkgs.alsa-utils];
}
