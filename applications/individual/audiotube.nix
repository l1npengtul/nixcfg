{pkgs, ...}: {
  home = {
    packages = [
      pkgs.kdePackages.audiotube
      pkgs.kdePackages.elisa
    ];
  };
}
