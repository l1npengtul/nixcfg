{
  config,
  pkgs,
  services,
  ...
}: {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      kdePackages.fcitx5-qt
      fcitx5-mozc
      fcitx5-hangul
    ];
  };

  services.xserver.desktopManager.runXdgAutostartIfNone = true;
}
