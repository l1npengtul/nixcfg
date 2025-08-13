{pkgs, ...}: let
  ruea = pkgs.callPackage ./rueaeconomystudio.nix {};
in {
  imports = [
    ./archives.nix
    ./java.nix
    ./nix-utils.nix
    ./sysutils.nix
    ./python3.nix
    ./rust.nix
    ./kdegtk.nix
    ./audio
    ./fcitx5
    ./fonts
    ./steam.nix
    ./libvirtd.nix
    ./protonvpn.nix
    #./matlab.nix I AM FREE!!!
    ./tailscale-client.nix
    ./input.nix
    ./diskmgmt.nix
    ./podman.nix
    ./sshd.nix
    ./printer.nix
    ./r.nix
    ./adb.nix
    ./email.nix
    ./keyboard.nix
    ./scanner.nix
    ./video.nix
  ];

  environment.systemPackages = [ruea];
}
