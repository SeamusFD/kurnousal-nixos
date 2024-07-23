{ pkgs, config, lib, ... }:
{
  options = {
    server.proxy.nginx.enable = lib.mkEnableOption "Enables the nginx reverse proxy";
  };
  config = lib.mkIf config.server.proxy.nginx.enable {
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

      # Use recommended settings
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      # Only allow PFS-enabled ciphers with AES256
      sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";

      appendHttpConfig = ''
        # Add HSTS header with preloading to HTTPS requests.
        # Adding this header to HTTP requests is discouraged
        map $scheme $hsts_header {
            https   "max-age=31536000; includeSubdomains; preload";
        }
        add_header Strict-Transport-Security $hsts_header;

        # Enable CSP for your services.
        #add_header Content-Security-Policy "script-src 'self'; object-src 'none'; base-uri 'none';" always;

        # Minimize information leaked to other domains
        add_header 'Referrer-Policy' 'origin-when-cross-origin';

        # Disable embedding as a frame
        add_header X-Frame-Options DENY;

        # Prevent injection of code in other mime types (XSS Attacks)
        add_header X-Content-Type-Options nosniff;

        # This might create errors
        proxy_cookie_path / "/; secure; HttpOnly; SameSite=strict";
      '';

      # Add any further config to match your needs, e.g.:
      virtualHosts =
        let
          base = locations: {
            inherit locations;

            forceSSL = true;
            enableACME = true;
          };
          proxy = port: base {
            "/".proxyPass = "http://192.168.1.129:" + toString port + "/";
          };
        in
        {
          # Define example.com as reverse-proxied service on 127.0.0.1:3000
          "jellyfin.kurnousal.net" = proxy 8096 // { default = true; };
        };
    };
  };
}
