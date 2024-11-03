{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      dorion
      legcord
      discord
    ];
  };
}
