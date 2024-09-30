{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
        dorion
        armcord
        discord
    ];
  };
}
