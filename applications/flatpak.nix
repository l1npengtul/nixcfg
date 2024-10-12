{...}: {
  services.flatpak.enable = true;

  services.flatpak.update.auto.enable = true;
  services.flatpak.uninstallUnmanaged = true;

  services.flatpak.packages = [
  ];
}
