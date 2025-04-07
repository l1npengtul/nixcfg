{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "madamoiselle";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "l1npengtul";
    repo = "madamoiselle";
    tag = "${version}";
    hash = "sha256-5hvfu33l5WkaEeVGb5ii9a325xBDhGiyev702zej1DQ=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-sNp8dpRawsL8ER4x1FylT3BHb3vfJwcOZa3Ud8sq6q8=";

  # Integration tests do not run in Nix build environment due to needing to
  # create and build Cargo workspaces.
  doCheck = false;
}
