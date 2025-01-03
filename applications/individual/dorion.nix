{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      dorion
      legcord
      discord
      discordchatexporter-desktop
    ];
  };
}
