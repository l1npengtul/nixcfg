{
  rustPlatform,
  fetchFromGitHub,
  sqlx-cli,
}: let
  version = "0.2.5";
in
  rustPlatform.buildRustPackage {
    pname = "madamoiselle";
    inherit version;

    src = fetchFromGitHub {
      owner = "l1npengtul";
      repo = "madamoiselle";
      tag = "${version}";
      hash = "sha256-6BgoUbf47Cg2/fISNBDm8T2Ml9s7IevHe1nNWxfJYWc=";
    };

    useFetchCargoVendor = true;
    cargoHash = "";

    nativeBuildInputs = [sqlx-cli];

    configurePhase = ''
      export DATABASE_URL=sqlite:database.sqlite
      sqlx database create
      sqlx database setup
      cargo sqlx prepare
    '';
  }
