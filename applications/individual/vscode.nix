{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
        rust-lang.rust-analyzer
        serayuzgur.crates
        zhuangtongfa.material-theme
        yzhang.markdown-all-in-one
        mkhl.direnv
    ];
  };
}
