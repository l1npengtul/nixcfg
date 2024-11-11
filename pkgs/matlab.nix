{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    inputs.nix-matlab.packages.x86_64-linux.matlab
    inputs.nix-matlab.packages.x86_64-linux.matlab-mlint
    inputs.nix-matlab.packages.x86_64-linux.matlab-mex
    pkgs.octaveFull
  ];
}
