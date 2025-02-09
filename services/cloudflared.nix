{
  config,
  pkgs,
  libs,
  ...
}: {
  environment.systemPackages = [pkgs.cloudflared];
}
