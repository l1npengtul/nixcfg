{pkgs, ...}: let
  rainyhearts-ttf = pkgs.callPackage ./custom/rainyhearts {inherit pkgs;};
  dalmoori-ttf = pkgs.callPackage ./custom/dalmoori {};
  pixelmplus-ttf = pkgs.callPackage ./custom/pixelmplus {};
in {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    liberation_ttf
    fira-code
    fira-code-symbols
    proggyfonts
    nerd-fonts.comic-shanns-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    rainyhearts-ttf
    dalmoori-ttf
    pixelmplus-ttf
  ];

  fonts.enableDefaultPackages = true;
  fonts.enableGhostscriptFonts = true;

  fonts.fontDir.enable = true;

  fonts.fontconfig = {
    defaultFonts = {
      sansSerif = ["rainyhearts" "Noto Sans CJK JA" "Noto Sans CJK KR"];
      monospace = ["ComicShannsMono Nerd Font Mono" "Noto Sans Mono CJK KR" "Noto Sans Mono CJK JA"];
    };
  };
}
