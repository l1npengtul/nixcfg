{
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  environment.variables = {
    NIX_SWITCH_BUILD_SYSTEM_CFG_PENGPENGPENG = "peng_tokyo_server";
  };

  time.timeZone = "Asia/Tokyo";

  users.users.pengsrv = {
    isNormalUser = true;
    createHome = true;
    shell = pkgs.nushell;
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
    trusted-users = root pengsrv
  '';

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

  fileSystems."/mnt/hdd_files" = {
    device = "/dev/disk/by-label/hdd_files";
    fsType = "auto";
    options = ["nosuid" "nodev" "nofail" "x-gvfs-show" "user" "exec" "relatime"];
  };

  hardware.graphics.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_6_12;
  networking.hostName = "peng_tokyo_server"; # Define your hostname.
  networking.firewall.enable = true;

  system.stateVersion = "24.05";
}
