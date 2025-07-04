{pkgs, ...}: let
  libbluray = pkgs.libbluray.override {
    withBDplus = true;
    withAACS = true;
  };
  vlc = pkgs.vlc.override {inherit libbluray;};
in {
  environment.systemPackages = with pkgs; [mpv libdvdcss libaacs vobcopy makemkv handbrake] ++ [libbluray vlc];
}
