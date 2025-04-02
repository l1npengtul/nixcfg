{pkgs, ...}: {
  users.users.l1npengtul = {
    isNormalUser = true;
    createHome = true;
    shell = pkgs.fish;
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
  programs.fish.enable = true;
  nix.extraOptions = ''
    trusted-users = root l1npengtul
  '';

  users.users."l1npengtul".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHmy492dN8mCQIP/f/ecxu9DIBHbhQF5Yte28CJZ1hgf l1npengtul@protonmail.com"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBITwQ7bUgxNBYdQFzWjRQkg9NW9s646icQZ/ifVitD4 l1npengtul@protonmail.com"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ6YTGD3iFT4DkdF9Qk4yE+Uxj3T2rjr3Qwh9KGLzwBZ l1npengtul@protonmail.com"
  ];
}
