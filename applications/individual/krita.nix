{pkgs, ...}: let
  krita-hidpi =
    pkgs.runCommand "krita" {
      buildInputs = [pkgs.makeWrapper];
    } ''
      mkdir $out
      # Link every top-level folder from pkgs.hello to our new target
      ln -s ${pkgs.krita}/* $out
      # Except the bin folder
      rm $out/bin
      mkdir $out/bin
      # We create the bin folder ourselves and link every binary in it
      ln -s ${pkgs.krita}/bin/* $out/bin
      # Except the hello binary
      rm $out/bin/krita
      # Because we create this ourself, by creating a wrapper
      makeWrapper ${pkgs.krita}/bin/krita $out/bin/krita \
        --set QT_SCALE_FACTOR 1.5
    '';
in {
  home = {
    packages = [
      krita-hidpi
    ];
  };
}
