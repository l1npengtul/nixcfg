{
  rustPlatform,
  fetchFromGitHub,
  sqlx-cli,
}: let
  version = "0.2.2";
in
  rustPlatform.buildRustPackage {
    pname = "madamoiselle";
    inherit version;

    src = fetchFromGitHub {
      owner = "l1npengtul";
      repo = "madamoiselle";
      tag = "${version}";
      hash = "sha256-5R2ZjsgEM4tqEYK7Q32rQSqI7jJh15nOriNKwxJvl0w=";
    };

    useFetchCargoVendor = true;
    cargoHash = "sha256-GRKZ9Mysdl/BJtnp7YA9XyzrEyCVxPbG4gYruT9JUII=";

    nativeBuildInputs = [sqlx-cli];

    configurePhase = ''
      export DATABASE_URL=sqlite:database.sqlite
      ls
      sqlx database create
      sqlx database setup
      cargo sqlx prepare
    '';
  }
