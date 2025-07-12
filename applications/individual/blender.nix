{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      blender
      trenchbroom
    ];
  };
}
