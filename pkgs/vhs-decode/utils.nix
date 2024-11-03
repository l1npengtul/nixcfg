{pkgs, ...}: let
  ffmpeg = pkgs.ffmpeg_7-full.override {
    withVpl = true;
    withMfx = false;
    withRav1e = true;
  };
in {
  environment.systemPackages = [pkgs.pv pkgs.sox pkgs.flac ffmpeg pkgs.handbrake pkgs.alsa-utils];
}
