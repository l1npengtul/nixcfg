{
  pkgs,
  pkgs-stable,
  ...
}: {
  home = {
    packages = [
      pkgs.jetbrains.rust-rover
      pkgs-stable.jetbrains.idea-community
      pkgs.jetbrains.clion
      pkgs.jetbrains.gateway
    ];
  };
}
