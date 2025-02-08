{
  pkgs,
  inputs,
  ...
}: {
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
    libraries = [
      (pkgs.runCommand "steamrun-lib" {}
        "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
    ];
  };

  environment.systemPackages = with pkgs; [protonup-qt r2modman inputs.flux.packages.${pkgs.system}.flux];

  hardware.steam-hardware.enable = true;
}
