{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      zhuangtongfa.material-theme
      yzhang.markdown-all-in-one
      mkhl.direnv
    ];
  };
}
