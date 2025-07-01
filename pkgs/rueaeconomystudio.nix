{
  buildGoModule,
  fetchFromGitHub,
  lib,
}: let
  version = "0.1.2-beta";
in
  buildGoModule {
    inherit version;
    pname = "ruea-economy-studio";

    src = fetchFromGitHub {
      owner = "Erwqs";
      repo = "RueaEconomyStudio";
      tag = "v${version}";
      hash = "sha256-1bgBUq3h/er5pszVtJfDrqf9QQ7UmJyvMC6Hf7fjk2I=";
    };

    vendorHash = "";

    meta = with lib; {
      description = "Wynncraft Economy Simulator";
      homepage = "https://github.com/Erwqs/RueaEconomyStudio";
      license = licenses.agpl3Only;
      maintainers = [maintainers.l1npengtul];
    };
  }
