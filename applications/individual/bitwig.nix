{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      bitwig-studio yabridgectl yabridge wineWowPackages.staging dxvk_2
    ];
  };
}
