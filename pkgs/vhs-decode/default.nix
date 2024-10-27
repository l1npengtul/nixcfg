{
  inputs,
  pkgs,
  config,
  ...
}: let
  kernel = config.boot.kernelPackages.kernel;
  cxadc = pkgs.callPackage ./cxadc.nix {inherit kernel;};
in {
  imports = [
    ./utils.nix
  ];
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with inputs.vhs-decode-nur-packages.packages.${pkgs.system}; [ab-av1 cxadc-vhs-server misrc-extract pyhht qwt tbc-video-export vapoursynth-bwdif vapoursynth-neofft3d vapoursynth-vsrawsource vhs-decode-auto-audio-align vhs-decode cxadc];

  boot.blacklistedKernelModules = ["cx8800"];
  boot.kernelParams = ["module_blacklist=cx8800"];
  boot.extraModulePackages = [cxadc];
  boot.kernelModules = ["cxadc"];
}
