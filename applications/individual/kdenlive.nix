{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      kdePackages.kdenlive
      openshot-qt
      davinci-resolve
    ];
  };
}
