{ pkgs, ... }:
{
    environment.systemPackages = [ pkgs.patchelf pkgs.dpkg ];
}
