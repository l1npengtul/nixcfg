{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      legcord
      discordchatexporter-desktop
      element-desktop
    ];
  };
}
