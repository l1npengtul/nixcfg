{pkgs, ...}: {
  environment.systemPackages = [pkgs.cockpit];

  services.cockpit = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall = {
    allowedTCPPorts = [9090];
  };
}
