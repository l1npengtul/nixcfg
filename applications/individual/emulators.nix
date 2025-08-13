{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      retroarch-free
      mame
      libretro.pcsx_rearmed
      #duckstation
      pcsx2
      rpcs3
    ];
  };
}
