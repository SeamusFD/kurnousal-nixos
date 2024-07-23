{ config, lib, ... }:
{
  options = {
    server.containers.nextcloud-container.enable = lib.mkEnableOption "Enables and sets up the Nextcloud container";
  };
  config = lib.mkIf config.server.containers.nextcloud-container.enable {
    services.nextcloud = {
      enable = true;
      home = "/var/lib/nextcloud";
      https = true;
      hostName = "nextcloud.kurnousal.net";
      settings = {
        trusted_domains = [
          "talk.nextcloud.kurnousal.net"
          "files.nextcloud.kurnousal.net"
        ];
      };
    };
  };
}
