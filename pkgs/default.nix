{
  imports = [
    ./archives.nix
    ./java.nix
    ./nix-utils.nix
    ./sysutils.nix
    ./python3.nix
    #./rustup.nix we use devshells now!
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
  ];
}
