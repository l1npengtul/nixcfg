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
    hash = "sha256-LBxZ0F0BpBimCiaqZDeyB1zndkgrTyDT4P6dJYDFEww=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-lnGjh88oh5UE4Uj2PtlJhxrevtE1kcQTYMloFR2tQIs=";

  # Integration tests do not run in Nix build environment due to needing to
  # create and build Cargo workspaces.
  doCheck = false;
}
