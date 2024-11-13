{pkgs, ...}: let
  wine = pkgs.wineWowPackages.staging.override {
    cupsSupport = true;
    gettextSupport = true;
    dbusSupport = true;
    cairoSupport = true;
    odbcSupport = true;
    netapiSupport = true;
    cursesSupport = true;
    vaSupport = true;
    pcapSupport = true;
    v4lSupport = true;
    saneSupport = true;
    gphoto2Support = true;
    krb5Support = true;
    fontconfigSupport = true;
    alsaSupport = true;
    pulseaudioSupport = true;
    udevSupport = true;
    vulkanSupport = true;
    sdlSupport = true;
    usbSupport = true;
    gstreamerSupport = true;
    gtkSupport = true;
    openclSupport = true;
    tlsSupport = true;
    waylandSupport = true;
  };
in {
  home = {
    packages = [
      pkgs.bitwig-studio
      pkgs.yabridgectl
      pkgs.yabridge
      wine
      pkgs.dxvk_2
    ];
  };
}
