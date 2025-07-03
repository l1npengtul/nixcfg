{
  rustPlatform,
  fetchFromGitHub,
  sqlx-cli,
}: let
  version = "0.2.6";
in
  rustPlatform.buildRustPackage {
    pname = "madamoiselle";
    inherit version;

    src = fetchFromGitHub {
      owner = "l1npengtul";
      repo = "madamoiselle";
      tag = "${version}";
      hash = "sha256-pv2uwBIHZog5LwGquoK6AX2EsjLJ4s77qpH0ym2hS6w=";
    };

    useFetchCargoVendor = true;
    cargoHash = "sha256-yAnLnYunaEPcaXWZGd0rDTnNrZAGBUY2Qu3C8aWrQ8M=";

    nativeBuildInputs = [sqlx-cli];

    configurePhase = ''
      export DATABASE_URL=sqlite:database.sqlite
      sqlx database create
      sqlx database setup
      cargo sqlx prepare
    '';
  }
