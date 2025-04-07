{
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../common/remote.nix
  ];

  time.timeZone = "Asia/Tokyo";
  boot.initrd.systemd.fido2.enable = false;
  users.users.pengsrv = {
    isNormalUser = true;
    createHome = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "video"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  nix.extraOptions = ''
    trusted-users = root pengsrv remotebuild
  '';

  nix.settings.trusted-users = ["@wheel" "pengsrv" "remotebuild"];

  #   boot.kernelParams = [ "security=selinux" ];
  #    boot.kernelPatches = [ {
  #         name = "selinux-config";
  #         patch = null;
  #         extraConfig = ''
  #                 SECURITY_SELINUX y
  #                 SECURITY_SELINUX_BOOTPARAM n
  #                 SECURITY_SELINUX_DISABLE n
  #                 SECURITY_SELINUX_DEVELOP y
  #                 SECURITY_SELINUX_AVC_STATS y
  #                 SECURITY_SELINUX_CHECKREQPROT_VALUE 0
  #                 DEFAULT_SECURITY_SELINUX n
  #               '';
  #         }
  #     ];

  #   environment.systemPackages = with pkgs; [ policycoreutils ];
  #   systemd.package = pkgs.systemd.override { withSelinux = true; };

  systemd.tmpfiles.rules = [
    "d /mnt/hdd_files 777 root root -"
  ];

  users.users."pengsrv".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHmy492dN8mCQIP/f/ecxu9DIBHbhQF5Yte28CJZ1hgf l1npengtul@protonmail.com"
  ];

  fileSystems."/mnt/hdd_files" = {
    device = "/dev/disk/by-label/hdd_files";
    fsType = "auto";
    options = ["nosuid" "nodev" "nofail" "x-gvfs-show" "user" "exec" "relatime"];
  };

  hardware.graphics.enable = true;
  boot.kernelPackages = pkgs-stable.linuxPackages_6_6;
  networking.hostName = "abandonedfactory"; # Define your hostname.
  networking.firewall.enable = true;

  system.stateVersion = "24.05";
}
