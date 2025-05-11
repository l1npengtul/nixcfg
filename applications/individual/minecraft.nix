{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      lunar-client
      prismlauncher
      glfw3-minecraft
    ];
  };
}
