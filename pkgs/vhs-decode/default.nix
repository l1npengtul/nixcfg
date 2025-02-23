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
  environment.systemPackages = with inputs.vhs-decode-nur-packages.packages.${pkgs.system}; [ab-av1 cxadc-vhs-server misrc-extract qwt tbc-video-export vapoursynth-bwdif vapoursynth-neofft3d vapoursynth-vsrawsource vhs-decode-auto-audio-align vhs-decode cxadc];
  services.udev.extraRules = ''
    KERNEL=="cxadc*", GROUP="video"

    # Rule for just cxadc0 to select vmux 0
    KERNEL=="cxadc0", SUBSYSTEM=="cxadc", ATTR{device/parameters/vmux}="1"
  '';

  boot.blacklistedKernelModules = ["cx8800"];
  boot.kernelParams = ["module_blacklist=cx8800"];
  boot.extraModulePackages = [cxadc];
  boot.kernelModules = ["cxadc"];
}
