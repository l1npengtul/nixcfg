{
  rustPlatform,
  fetchFromGitHub,
  sqlx-cli,
}: let
  version = "0.2.3";
in
  rustPlatform.buildRustPackage {
    pname = "madamoiselle";
    inherit version;

    src = fetchFromGitHub {
      owner = "l1npengtul";
      repo = "madamoiselle";
      tag = "${version}";
      hash = "sha256-rtC2QB1HzYFvFCJCmxf4UF/7E3qkp2+r8/2MYZGW9Jo=";
    };

    useFetchCargoVendor = true;
    cargoHash = "sha256-UMCP77d+Q5aH185UiQL7HyjT2FlkP8MYTg+rJeZq3k8=";

    nativeBuildInputs = [sqlx-cli];

    configurePhase = ''
      export DATABASE_URL=sqlite:database.sqlite
      sqlx database create
      sqlx database setup
      cargo sqlx prepare
    '';
  }
