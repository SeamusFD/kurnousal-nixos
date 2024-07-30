{ config, lib, ... }:
{
  options = {
    server.containers.vaultwarden-container.enable = lib.mkEnableOption "Enables and sets up the Vaultwarden container";
  };
  config = lib.mkIf config.server.containers.vaultwarden-container.enable {
    services.vaultwarden = {
      enable = true;
      dbBackend = "postgresql";
      environmentFile = "/var/lib/vaultwarden/.env";
      config = {
        ROCKET_ADDRESS = "192.168.1.3";
        ROCKER_PORT = 8222;
        ROCKET_LOG = "critical";

        SIGNUPS_ALLOWED = true;
        DOMAIN = "https://vaultwarden.kurnousal.net";
      };
    };
  };
}
