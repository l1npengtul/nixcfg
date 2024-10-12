{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [pkgs.nil pkgs.nixfmt-rfc-style inputs.alejandra.defaultPackage.${pkgs.system} pkgs.patchelfUnstable pkgs.file];
}
