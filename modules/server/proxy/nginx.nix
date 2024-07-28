{ pkgs, config, lib, ... }:
{
  options = {
    server.proxy.nginx.enable = lib.mkEnableOption "Enables the nginx reverse proxy";
  };
  config = lib.mkIf config.server.proxy.nginx.enable {
    networking.hosts = {
      "192.168.1.3" = [
        "jellyfin.kurnousal.net"
      ];
    };
    security.acme = {
      acceptTerms = true;
      defaults = {
        email = "seamusfd@proton.me";
        dnsProvider = "dreamhost";
        environmentFile = "${pkgs.writeText "dreamhost-key" ''
          DREAMHOST_API_KEY="MA24UAHG3M88VCK7"
        ''}";
      };
    };
    services.nginx = {
      enable = true;
      recommendedProxySettings = false;

      virtualHosts = {
        "jellyfin.kurnousal.net" = {
          # Generate lets encrypt certificate using DNS challenge
          forceSSL = true;
          enableACME = true;
          acmeRoot = null;

          locations."/" = {
            proxyPass = "http://192.168.1.3:8096";
            proxyWebsockets = true;
            recommendedProxySettings = true;
          };
        };
        "gitlab.kurnousal.net" = {
          # Generate lets encrypt certificate using DNS challenge
          forceSSL = true;
          enableACME = true;
          acmeRoot = null;

          locations."/" = {
            proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
          };
        };
      };
    };
  };
}
