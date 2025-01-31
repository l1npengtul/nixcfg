{pkgs, ...}: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession.enable = true;
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = [pkgs.steam-run.fhsenv.args.multiPkgs pkgs];
  };

  environment.systemPackages = with pkgs; [protonup-qt];

  hardware.steam-hardware.enable = true;
}
