{...}: {
  powerManagement = {
    powertop.enable = true;
  };

  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;
  services.tlp.settings = {
    SOUND_POWER_SAVE_ON_BAT = 1;

    INTEL_GPU_MIN_FREQ_ON_AC = 0;
    INTEL_GPU_MIN_FREQ_ON_BAT = 0;
    INTEL_GPU_MAX_FREQ_ON_AC = 0;
    INTEL_GPU_MAX_FREQ_ON_BAT = 0;
    INTEL_GPU_BOOST_FREQ_ON_AC = 0;
    INTEL_GPU_BOOST_FREQ_ON_BAT = 0;

    PCIE_ASPM_ON_AC = "powersave";
    PCIE_ASPM_ON_BAT = "powersupersave";

    START_CHARGE_THRESH_BAT0 = 65;
    STOP_CHARGE_THRESH_BAT0 = 85;
  };
  services.thermald.enable = true;
  programs.auto-cpufreq.enable = true;
  programs.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      energy_performance_preference = "power";
      turbo = "never";
    };
    charger = {
      governor = "powersave";
      energy_performance_preference = "balance_power";
      turbo = "auto";
    };
  };

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  services.system76-scheduler.settings.cfsProfiles.enable = true;

  hardware.sensor.iio.enable = true;
}
