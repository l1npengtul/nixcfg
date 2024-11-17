{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      kdenlive
      openshot-qt
    ];
  };
}
