{
  rustPlatform,
  fetchFromGitHub,
  sqlx-cli,
}:
rustPlatform.buildRustPackage rec {
  pname = "madamoiselle";
  version = "0.2.0";

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
}
