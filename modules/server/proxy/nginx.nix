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

      upstreams.gitlab-workhorse.servers = {
        "unix:/run/gitlab/gitlab-workhorse.socket" = { };
      };

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
        "vaultwarden.kurnousal.net" = {
          # Generate lets encrypt certificate using DNS challenge
          forceSSL = true;
          enableACME = true;
          acmeRoot = null;

          locations."/" = {
            proxyPass = "http://192.168.1.3:8222";
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
            proxyPass = "http://gitlab-workhorse";
            extraConfig = ''
              proxy_http_version 1.1;
              proxy_set_header Upgrade $http_upgrade;
              proxy_set_header Connection $connection_upgrade;
            '';
            recommendedProxySettings = true;
          };
        };
      };
    };
  };
}
