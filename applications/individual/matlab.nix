{inputs, ...}: {
  home = {
    packages = [
      inputs.nix-matlab.packages.x86_64-linux.matlab
      inputs.nix-matlab.packages.x86_64-linux.matlab-mlint
      inputs.nix-matlab.packages.x86_64-linux.matlab-mex
    ];
    file.".config/matlab/nix.sh" = {
      text = "INSTALL_DIR=$HOME/matlab";
    };
  };
}
