{pkgs, ...}: {
  imports = [
    ./common.nix
    ./common-plasma.nix
  ];

  home = {
    packages = with pkgs; [
      cowsay
      devenv
    ];

    stateVersion = "24.05";
  };
}
