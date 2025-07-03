{
  rustPlatform,
  fetchFromGitHub,
  sqlx-cli,
}: let
  version = "0.2.0";
in
  rustPlatform.buildRustPackage {
    pname = "madamoiselle";
    inherit version;

    src = fetchFromGitHub {
      owner = "l1npengtul";
      repo = "madamoiselle";
      tag = "${version}";
      hash = "sha256-B6AJ7TYKvnJg65VakrqDB8CorSyU4sK2Qc7gUjwZsHQ=";
    };

    useFetchCargoVendor = true;
    cargoHash = "sha256-GRKZ9Mysdl/BJtnp7YA9XyzrEyCVxPbG4gYruT9JUII=";

    nativeBuildInputs = [sqlx-cli];

    preCheck = ''
      cargo sqlx prepare
    '';

    configurePhase = ''
      ls
      cargo sqlx prepare
    '';
  }
