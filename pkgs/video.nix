{pkgs, ...}: {
  environment.systemPackages = with pkgs; [mpv libdvdcss libaacs vobcopy makemkv handbrake libbluray vlc];
}
