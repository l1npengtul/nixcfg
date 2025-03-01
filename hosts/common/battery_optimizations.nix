{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    auto-cpufreq
  ];

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

  hardware.sensor.iio.enable = true;
}
