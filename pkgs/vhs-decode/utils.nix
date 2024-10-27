{pkgs, ...}: {
  environment.systemPackages = [pkgs.pv pkgs.sox pkgs.flac pkgs.ffmpeg_7-full];
}
