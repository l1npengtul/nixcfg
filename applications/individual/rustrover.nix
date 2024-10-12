{pkgs, ...}: {
  home = {
    packages = [
      pkgs.jetbrains.rust-rover
      pkgs.jetbrains.idea-community
    ];
  };
}
