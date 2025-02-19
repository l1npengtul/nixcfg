{
  pkgs,
  ...
}: {
  imports = [
#     ./hardware-configuration.nix
    ./../common/use-remote.nix
  ];
  environment.systemPackages = with pkgs; [
    auto-cpufreq
  ];

  time.timeZone = "Asia/Tokyo";

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

  boot.kernelParams = ["mem_sleep_default=deep"];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  powerManagement = {
    powertop.enable = true;
  };

  services.hardware.bolt.enable = true;

  services.power-profiles-daemon.enable = false;
  services.tlp.enable = false;
  services.thermald.enable = true;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    thresholds = {
      enable = true;
      start = 50;
      stop = 85;
    };
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  users.users."l1npengtul".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHmy492dN8mCQIP/f/ecxu9DIBHbhQF5Yte28CJZ1hgf l1npengtul@protonmail.com"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBITwQ7bUgxNBYdQFzWjRQkg9NW9s646icQZ/ifVitD4 l1npengtul@protonmail.com"
  ];

  services.system76-scheduler.settings.cfsProfiles.enable = true;

  #     services.tlp = {
  #         enable = true;
  #
  #         settings = {
  #
  #             START_CHARGE_THRESH_BAT0 = 50; # 40 and bellow it starts to charge
  #             STOP_CHARGE_THRESH_BAT0 = 85; # 80 and above it stops charging
  #         };
  #     };

  hardware.sensor.iio.enable = true;
  #hardware.ipu6 = {
  #  enable = true;
  #  platform = "ipu6epmtl";
  #};
  hardware.ipu6.enable = false;
  boot.blacklistedKernelModules = ["intel_ipu6" "intel_ipu6_isys" "intel_ipu6_isys.isys"]; # not sure if all of them are required
  hardware.graphics = {
    # hardware.opengl in 24.05
    enable = true;
    enable32Bit = true; # driSupport32Bit in 24.05
    extraPackages = with pkgs; [
      intel-compute-runtime
      vpl-gpu-rt
    ];
  };

  networking.hostName = "s-23sierpinski"; # Define your hostname.

  system.stateVersion = "24.11";
}
