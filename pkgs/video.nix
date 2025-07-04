{pkgs, ...}: let
  libbluray = pkgs.libbluray.override {
    withBDplus = true;
    withAACS = true;
    withJava = true;
  };
in {
  environment.systemPackages = with pkgs; [mpv vlc libdvdcss libaacs vobcopy makemkv handbrake] ++ [libbluray];
}
