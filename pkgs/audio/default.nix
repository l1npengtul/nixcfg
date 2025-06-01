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
  slplugins = pkgs.callPackage ./socalabs/slplugins.nix {};
  sn76489 = pkgs.callPackage ./socalabs/sn76489.nix {};
  voc = pkgs.callPackage ./socalabs/voc.nix {};
  wavetable = pkgs.callPackage ./socalabs/wavetable.nix {};
  test = pkgs.callPackage ./test.nix {};
  dora-search = pkgs.callPackage ./demucs/dora-search.nix {};
  lameenc = pkgs.callPackage ./demucs/lameenc.nix {};
  openunmix = pkgs.python3Packages.callPackage ./demucs/openunmix.nix {};
  #demucs = pkgs.python3Packages.callPackage ./demucs/demucs.nix {
  #  openunmix = openunmix;
  # lameenc = lameenc;
  # dora-search = dora-search;
  #};
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
    zam-plugins
    chow-tape-model
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

    airwindows
    airwin2rack
    socalabs-sid
    sn76489
    papu
    rp2a03
    voc
    organ
    wavetable
    piano
    slplugins
    decent-sampler

    lameenc
    dora-search
    openunmix
    #demucs

    inputs.audio.packages.${pkgs.system}.paulxstretch
    #inputs.audio.packages.${pkgs.system}.grainbow
    inputs.audio.packages.${pkgs.system}.neuralnote
    inputs.audio.packages.${pkgs.system}.atlas2
  ];
}
