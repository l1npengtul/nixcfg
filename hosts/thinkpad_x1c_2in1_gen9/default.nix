{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];
  environment.systemPackages = with pkgs; [
    auto-cpufreq
  ];

  environment.variables = {
    NIX_SWITCH_BUILD_SYSTEM_CFG_PENGPENGPENG = "thinkpad_x1c_2in1_gen9";
  };

  boot.kernelParams = ["mem_sleep_default=deep" "intel_pstate=disable"];
  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-label/MAGPIE_SIGNAL";

  powerManagement = {
    powertop.enable = true;
  };

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

  boot.blacklistedKernelModules = ["intel_pstate"];

  hardware.graphics.enable = true;
  hardware.sensor.iio.enable = true;
  hardware.ipu6.enable = true;
  hardware.ipu6.platform = "ipu6epmtl";

  networking.hostName = "oldhome"; # Define your hostname.

  specialisation = {
    egpu.configuration = {
      hardware.graphics.enable = true;
      hardware.amdgpu.initrd.enable = true;
      hardware.enableAllFirmware = true;
      system.nixos.tags = ["egpu"];

      boot = {
        # Ensure module for external graphics is loaded
        initrd.kernelModules = ["amdgpu"];

        blacklistedKernelModules = ["intel_pstate"];

        # Disable the integrated graphics module
        kernelParams = [
          "amdgpu.pcie_gen_cap=0x40000" # Force AMD GPU to use full width (optional)
        ];
      };

      # Use external graphics
      services.xserver.videoDrivers = ["modesetting" "amdgpu"];
    };
  };

  system.stateVersion = "24.05";
}
