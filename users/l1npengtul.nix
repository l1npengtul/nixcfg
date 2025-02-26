{pkgs, ...}: {
  imports = [
    ./common.nix
    ./common-plasma.nix
  ];

  home = {
    packages = with pkgs; [
      cowsay
      plasma-overdose-kde-theme
      maliit-keyboard
      maliit-framework
      kdePackages.plasma-thunderbolt
    ];

    stateVersion = "24.05";
  };
}
