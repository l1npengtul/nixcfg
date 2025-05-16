{pkgs, ...}:
with pkgs; let
  customR = rstudioWrapper.override {packages = with rPackages; [ggplot2 dplyr xts rmarkdown knitr BSDA MASS lme4 bblme MuMIn DHARMa];};
in {
  environment.systemPackages = with pkgs; [customR];
}
