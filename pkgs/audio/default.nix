{
  inputs,
  pkgs,
  ...
}: let
  #     buildGradlePackage = inputs.gradle2nix.builders.x86_64-linux.buildGradlePackage;
  socalabs = pkgs.callPackage ./socalabs {};
  airwindows = pkgs.callPackage ./airwindows {};
  #   synthv-studio-pro = pkgs.callPackage ./synthv-studio-pro {};
  recstar = pkgs.callPackage ./recstar {};
in {
  environment.systemPackages = with pkgs; [
    odin2
    surge-XT
    lsp-plugins
    qpwgraph
    dexed
    audacity
    musescore
    paulstretch
    socalabs
    vital
    airwindows
    #     synthv-studio-pro # fuck you dreamtonics
    recstar
    inputs.audio.packages.${pkgs.system}.vital
    inputs.audio.packages.${pkgs.system}.paulxstretch
    inputs.audio.packages.${pkgs.system}.grainbow
    inputs.audio.packages.${pkgs.system}.neuralnote
    inputs.audio.packages.${pkgs.system}.atlas2
  ];
}
