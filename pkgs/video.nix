{pkgs, ...}: let
  libbluray = pkgs.libbluray.override {
    withAACS = true;
    withBDplus = true;
    withJava = true;
  };
  libdvdcss = pkgs.libdvdcss;
  vlc = pkgs.vlc.override {inherit libbluray libdvdcss;};
in {
  environment.systemPackages = with pkgs; [mpv vlc];
}
