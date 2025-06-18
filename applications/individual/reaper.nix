{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    reaper
    reaper-reapack-extension
    reaper-sws-extension
  ];

  xdg.configFile.REAPER = {
    enable = true;
    force = true;
    source = pkgs.symlinkJoin {
      name = "reaper-userplugins";
      paths = with pkgs; [
        reaper-sws-extension
        reaper-reapack-extension
      ];
    };
  };
}
