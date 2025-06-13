{pkgs, ...}: let
  customRStudio = pkgs.rstudioWrapper.override {packages = with pkgs.rPackages; [ggplot2 dplyr xts rmarkdown knitr BSDA MASS lme4 blme MuMIn DHARMa FSA];};
  customR = pkgs.rWrapper.override {packages = with pkgs.rPackages; [ggplot2 dplyr xts rmarkdown knitr BSDA MASS lme4 blme MuMIn DHARMa FSA];};
in {
  environment.systemPackages = [customR customRStudio];
}
