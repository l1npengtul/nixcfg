{pkgs, ...}: {
  environment.packages = with pkgs; [util-linux gptfdisk gparted];
}
