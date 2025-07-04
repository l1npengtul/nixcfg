{pkgs, ...}: let
in {
  environment.systemPackages = with pkgs; [mpv vlc libdvdcss libaacs libbluray vobcopy makemkv];
}
