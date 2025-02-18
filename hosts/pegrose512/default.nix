{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.musnix.nixosModules.musnix
  ];

  time.timeZone = "Asia/Seoul";

  users.users.l1npengtul = {
    isNormalUser = true;
    createHome = true;
    shell = pkgs.nushell;
    extraGroups = [
      "wheel"
      "audio"
      "networkmanager"
      "libvirtd"
      "jackaudio"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  nix.extraOptions = ''
    trusted-users = root l1npengtul
  '';

  boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems."/home/l1npengtul/project" = {
    device = "/dev/disk/by-uuid/125413e8-0b7a-464f-9d83-fa4e00f00a35";
    fsType = "ext4";
  };

  hardware.graphics = {
    # hardware.opengl in 24.05
    enable = true;
    enable32Bit = true; # driSupport32Bit in 24.05
  };

  networking.hostName = "pegrose512"; # Define your hostname.

  musnix.enable = true;
  musnix.rtcqs.enable = true;

  system.stateVersion = "24.11";
}
