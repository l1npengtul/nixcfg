{pkgs, ...}: let
  rainyhearts-ttf = pkgs.callPackage ./custom/rainyhearts {inherit pkgs;};
  dalmoori-ttf = pkgs.callPackage ./custom/dalmoori {};
  pixelmplus-ttf = pkgs.callPackage ./custom/pixelmplus {};
in {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    liberation_ttf
    fira-code
    fira-code-symbols
    proggyfonts
    nerdfonts
    rainyhearts-ttf
    dalmoori-ttf
    pixelmplus-ttf
  ];

  fonts.enableDefaultPackages = true;
  fonts.enableGhostscriptFonts = true;

  fonts.fontDir.enable = true;

  fonts.fontconfig = {
    defaultFonts = {
      sansSerif = ["rainyhearts" "dalmoori" "PixelMplus12" "Noto Sans CJK JA"];
      monospace = ["ComicShannsMono Nerd Font Mono" "Noto Sans Mono CJK KR" "Noto Sans Mono CJK JA"];
    };
  };
}
