{
  inputs,
  pkgs,
  pkgs-stable,
  pkgs-master,
  ...
}: let
  #     buildGradlePackage = inputs.gradle2nix.builders.x86_64-linux.buildGradlePackage;
  organ = pkgs.callPackage ./socalabs/organ.nix {};
  papu = pkgs.callPackage ./socalabs/papu.nix {};
  piano = pkgs.callPackage ./socalabs/piano.nix {};
  rp2a03 = pkgs.callPackage ./socalabs/rp2a03.nix {};
  sid = pkgs.callPackage ./socalabs/sid.nix {enableVST2 = true;};
  slplugins = pkgs.callPackage ./socalabs/slplugins.nix {};
  sn76489 = pkgs.callPackage ./socalabs/sn76489.nix {};
  voc = pkgs.callPackage ./socalabs/voc.nix {};
  wavetable = pkgs.callPackage ./socalabs/wavetable.nix {};
  test = pkgs.callPackage ./test.nix {};
  airwindows = pkgs.callPackage ./airwindows {};
  airwindows-ind = pkgs.callPackage ./airwindows/individual.nix {};
  socalabsall = pkgs.callPackage ./socalabs/all.nix {};
  #   synthv-studio-pro = pkgs.callPackage ./synthv-studio-pro {};
  recstar = pkgs.callPackage ./recstar {};
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
    setbfree
    zynaddsubfx
    audacity
    musescore
    paulstretch
    bespokesynth-with-vst2
    oxefmsynth
    ninjas2
    zam-plugins
    chow-tape-model
    vcv-rack
    cardinal
    pkgs-master.carla
    alsa-utils
    vital
    distrho-ports
    airwindows-lv2
    bitwig-studio
    ardour
    reaper
    pkgs-stable.yabridgectl
    pkgs-stable.yabridge
    pkgs-stable.wineWowPackages.stagingFull
    dxvk_2
    recstar

    #test
    airwindows-ind
    sid
    sn76489
    papu
    rp2a03
    voc

    inputs.audio.packages.${pkgs.system}.paulxstretch
    inputs.audio.packages.${pkgs.system}.grainbow
    inputs.audio.packages.${pkgs.system}.neuralnote
    inputs.audio.packages.${pkgs.system}.atlas2
  ];
}
