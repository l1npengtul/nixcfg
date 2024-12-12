{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      kdePackages.konversation
    ];
  };
}
