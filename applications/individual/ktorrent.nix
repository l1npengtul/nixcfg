{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      kdePackages.ktorrent
    ];
  };

}
