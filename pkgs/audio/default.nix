{
  inputs,
  pkgs,
  pkgs-stable,
  pkgs-master,
  ...
}: let
  organ = pkgs.callPackage ./socalabs/organ.nix {};
  papu = pkgs.callPackage ./socalabs/papu.nix {};
  piano = pkgs.callPackage ./socalabs/piano.nix {};
  rp2a03 = pkgs.callPackage ./socalabs/rp2a03.nix {};
  slplugins = pkgs.callPackage ./socalabs/slplugins.nix {};
  sn76489 = pkgs.callPackage ./socalabs/sn76489.nix {};
  voc = pkgs.callPackage ./socalabs/voc.nix {};
  wavetable = pkgs.callPackage ./socalabs/wavetable.nix {};
  treetable = pkgs.callPackage ./demucs/treetable.nix {};
  submitit = pkgs.callPackage ./demucs/submitit.nix {};
  dora-search = pkgs.callPackage ./demucs/dora-search.nix {
    treetable = treetable;
    submitit = submitit;
  };
  lameenc = pkgs.callPackage ./demucs/lameenc.nix {};
  openunmix = pkgs.python3Packages.callPackage ./demucs/openunmix.nix {};
  demucs = pkgs.callPackage ./demucs/demucs.nix {
    openunmix = openunmix;
    lameenc = lameenc;
    dora-search = dora-search;
  };
  paulxstretch = pkgs.callPackage ./paulxstretch.nix {};
  ripplerx = pkgs.callPackage ./ripplerx.nix {};
  #grainbow = pkgs.callPackage ./grainbow {};
  #   synthv-studio-pro = pkgs.callPackage ./synthv-studio-pro {};
  recstar = pkgs.callPackage ./recstar {};
  nn = pkgs.callPackage ./neuralnote.nix {};
  #musescore-evolution = pkgs.callPackage ./musescore-evolution.nix {};
in {
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    odin2
    #surge-XT
    lsp-plugins
    qpwgraph
    dexed
    #setbfree
    #zynaddsubfx
    #audacity
    musescore
    #musescore-evolution
    #paulstretch
    #zam-plugins
    #chow-tape-model
    vcv-rack
    cardinal
    alsa-utils
    vital
    distrho-ports
    bitwig-studio
    pkgs-stable.yabridgectl
    pkgs-stable.yabridge
    wineWowPackages.stagingFull
    dxvk_2
    recstar
    plugdata
    dl-librescore
    #carla

    #airwindows
    #airwin2rack
    #socalabs-sid
    #sn76489
    #papu
    #rp2a03
    #voc
    #organ
    #wavetable
    piano
    #slplugins
    decent-sampler
    #friture

    #demucs

    sfizz
    linuxsampler

    sonic-visualiser

    paulxstretch
    ripplerx
    #grainbow
    inputs.audio.packages.${pkgs.system}.atlas2
    nn
  ];
}
