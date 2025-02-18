{pkgs, ...}: {
  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  users.users."pengsrv".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHmy492dN8mCQIP/f/ecxu9DIBHbhQF5Yte28CJZ1hgf l1npengtul@protonmail.com"
  ];

  users.users."l1npengtul".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHmy492dN8mCQIP/f/ecxu9DIBHbhQF5Yte28CJZ1hgf l1npengtul@protonmail.com"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBITwQ7bUgxNBYdQFzWjRQkg9NW9s646icQZ/ifVitD4 l1npengtul@protonmail.com"
  ];

  networking.firewall = {
    allowedTCPPorts = [22];
  };
}
