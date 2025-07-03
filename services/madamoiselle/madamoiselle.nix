{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "madamoiselle";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "l1npengtul";
    repo = "madamoiselle";
    tag = "${version}";
    hash = "";
  };

  useFetchCargoVendor = true;
  cargoHash = "";

  # Integration tests do not run in Nix build environment due to needing to
  # create and build Cargo workspaces.
  doCheck = false;
}
