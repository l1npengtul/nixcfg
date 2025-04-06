{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "madamoiselle";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "l1npengtul";
    repo = "madamoiselle";
    tag = "${version}";
    hash = "sha256-ZWX6dddYEzp6au+Oi8N5OaC8uy2dTRE2MhWClUvlFhw=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-BjxcZt3qKLzFWyrupGrj4/psK2Y5si2MhOeZPGBG7d0=";

  # Integration tests do not run in Nix build environment due to needing to
  # create and build Cargo workspaces.
  doCheck = false;
}
