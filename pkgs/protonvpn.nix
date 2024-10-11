{ pkgs, ... }:
{
    environment.systemPackages = [ pkgs.wireguard-tools pkgs.protonvpn-gui ];
}
