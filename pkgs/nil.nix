{ pkgs, ... }:
{
    environment.systemPackages = [ pkgs.nil pkgs.nixfmt-rfc-style ];
}
