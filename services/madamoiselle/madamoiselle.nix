{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "madamoiselle";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "l1npengtul";
    repo = "madamoiselle";
    tag = "${version}";
    hash = "sha256-HOrrXlefzBCqwfIR16VT1N67+hVNU674K29NgnnpgCo=";
  };

  useFetchCargoVendor = true;
  cargoHash = "";

  # Integration tests do not run in Nix build environment due to needing to
  # create and build Cargo workspaces.
  doCheck = false;
}
