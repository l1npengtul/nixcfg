{pkgs, ...}: {
  home = {
    packages = [
      pkgs.vlc
      pkgs.mpv
      pkgs.handbrake
    ];
  };
}
