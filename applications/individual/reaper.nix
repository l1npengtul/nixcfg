{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    reaper
    #    reaper-reapack-extension
    #    reaper-sws-extension
  ];

  home.file.sws-extension = {
    source = "${pkgs.reaper-sws-extension}/UserPlugins/reaper_sws-x86_64.so";
    target = ".config/REAPER/UserPlugins/reaper_sws-x86_64.so";
  };

  home.file.sws-script1 = {
    source = "${pkgs.reaper-sws-extension}/Scripts/sws_python.py";
    target = "$.config/REAPER/Scripts/sws_python.py";
  };

  home.file.sws-script2 = {
    source = "${pkgs.reaper-sws-extension}/Scripts/sws_python64.py";
    target = ".config/REAPER/Scripts/sws_python64.py";
  };

  home.file.reapack = {
    source = "${pkgs.reaper-reapack-extension}/UserPlugins/reaper_reapack-x86_64.so";
    target = "$.config/REAPER/UserPlugins/reaper_reapack-x86_64.so";
  };
}
