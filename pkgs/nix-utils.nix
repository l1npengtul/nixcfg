{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [pkgs.nil pkgs.nixfmt-rfc-style inputs.alejandra.defaultPackage.${pkgs.system} pkgs.patchelfUnstable pkgs.file pkgs.nix-prefetch-github pkgs.nixpkgs-review pkgs.nix-update pkgs.nix-du];
  programs.nix-index-database.comma.enable = true;
}
