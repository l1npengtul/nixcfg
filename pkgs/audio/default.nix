{
  inputs,
  pkgs,
  pkgs-stable,
  ...
}: let
  #     buildGradlePackage = inputs.gradle2nix.builders.x86_64-linux.buildGradlePackage;
  organ = pkgs.callPackage ./socalabs/organ.nix {};
  papu = pkgs.callPackage ./socalabs/papu.nix {};
  piano = pkgs.callPackage ./socalabs/piano.nix {};
  rp2a03 = pkgs.callPackage ./socalabs/rp2a03.nix {};
  sid = pkgs.callPackage ./socalabs/sid.nix {};
  slplugins = pkgs.callPackage ./socalabs/slplugins.nix {};
  sn76489 = pkgs.callPackage ./socalabs/sn76489.nix {};
  voc = pkgs.callPackage ./socalabs/voc.nix {};
  wavetable = pkgs.callPackage ./socalabs/wavetable.nix {};
  wsjtz = {
    wsjtx,
    fetchzip,
    lib,
  }:
    wsjtx.overrideAttrs (old: rec {
      pname = "wsjtz";
      version = "2.7.0-rc7-1.43";

      src = fetchzip {
        url = "https://psychz.dl.sourceforge.net/project/wsjt-z/Source/wsjtz-${version}.zip";
        hash = "sha256-m+P83S5P9v3NPtifc+XjZm/mAOs+NT9fTWXisxuWtZo=";
      };

      postFixup = ''
        mv $out/bin/wsjtx $out/bin/wsjtz
        mv $out/bin/wsjtx_app_version $out/bin/wsjtz_app_version
      '';

      meta = with lib; {
        description = "WSJT-X fork, primarily focused on automation and enhanced functionality";
        homepage = "https://sourceforge.net/projects/wsjt-z/";
        license = lib.licenses.gpl3;
        platforms = platforms.linux;
        mainProgram = "wsjtz";
      };
    });
  airwindows = pkgs.callPackage ./airwindows {};
  #   synthv-studio-pro = pkgs.callPackage ./synthv-studio-pro {};
  recstar = pkgs.callPackage ./recstar {};
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
  imports = [
    ./audiothing
  ];

  environment.systemPackages = with pkgs; [
    odin2
    surge-XT
    lsp-plugins
    qpwgraph
    dexed
    audacity
    musescore
    paulstretch

    #sid
    wsjtz
    vital
    #airwindows
    #     synthv-studio-pro # fuck you dreamtonics
    plugdata
    alsa-utils
    pkgs-stable.bitwig-studio
    yabridgectl
    yabridge
    wine
    dxvk_2
    recstar
    inputs.audio.packages.${pkgs.system}.vital
    inputs.audio.packages.${pkgs.system}.paulxstretch
    inputs.audio.packages.${pkgs.system}.grainbow
    inputs.audio.packages.${pkgs.system}.neuralnote
    inputs.audio.packages.${pkgs.system}.atlas2
  ];
}
