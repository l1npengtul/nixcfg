{pkgs, ...}: {
  imports = [
    ./common.nix
    ./common-plasma.nix
  ];

  home = {
    packages = with pkgs; [
      cowsay
      xdg-desktop-portal-kde
      devenv
    ];
  };
}
