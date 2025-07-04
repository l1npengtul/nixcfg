{pkgs, ...}: let
in {
  environment.systemPackages = with pkgs; [mpv vlc libdvdcss];
}
