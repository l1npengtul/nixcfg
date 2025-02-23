{...}: {
  users.users.remotebuild = {
    isNormalUser = true;
    createHome = false;
    group = "remotebuild";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH6Eat2YPbwb1FMFXXr2JWVY75l5hba3GFBuQMh/y2N/ root@oldhome"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGj9wCUYzGaf1gClP9YbJNMxxTVOPS2tyFP870bcgZEH root@s-23sierpinski"
    ];
  };

  users.groups.remotebuild = {};

  nix.settings.trusted-users = ["remotebuild"];
  nix.settings.max-jobs = "auto";
  nix.settings.cores = 0;
}
