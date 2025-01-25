{pkgs, ...}: {
  nix.distributedBuilds = true;
  nix.settings.builders-use-substitutes = true;

  nix.buildMachines = [
    {
      hostName = "abandonedfactory";
      sshUser = "remotebuild";
      sshKey = "/root/.ssh/remotebuild";
      system = pkgs.stdenv.hostPlatform.system;
      supportedFeatures = ["nixos-test" "big-parallel" "kvm"];
      protocol = "ssh-ng";
      max-jobs = "auto";
    }
  ];
}
