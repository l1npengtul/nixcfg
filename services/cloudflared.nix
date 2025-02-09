{
  config,
  pkgs,
  libs,
  ...
}: {
  environment.systemPackages = [pkgs.cloudflared];

  services.cloudflared = {
    enabled = true;
    tunnels = {
      "c0a14307-5aae-475e-830b-e7fcc62a567d" = {
        credintalsFile = "${config.age.secrets.cloudflared-minecraftproxy-secret.path}";
        default = "http_status:404";
      };
    };
  };
}
