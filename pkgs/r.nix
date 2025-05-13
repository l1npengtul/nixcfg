{pkgs, ...}: {
  environment.systemPackages = with pkgs; [R rPackages.ggplot2 rPackages.dplyr rPackages.xts rstudioWrapper];
}
