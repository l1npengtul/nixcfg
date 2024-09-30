{ inputs, pkgs, ... }:
let
    socalabs = pkgs.callPackage ./socalabs { };
    airwindows = pkgs.callPackage ./airwindows { };
    synthv-studio-pro = pkgs.callPackage ./synthv-studio-pro { };

in
{
    environment.systemPackages = with pkgs; [ odin2 surge-XT lsp-plugins qpwgraph dexed audacity musescore paulstretch socalabs vital airwindows synthv-studio-pro
        inputs.audio.packages.${pkgs.system}.vital
        inputs.audio.packages.${pkgs.system}.paulxstretch
        inputs.audio.packages.${pkgs.system}.grainbow
        inputs.audio.packages.${pkgs.system}.neuralnote
        inputs.audio.packages.${pkgs.system}.atlas2
    ];
}
