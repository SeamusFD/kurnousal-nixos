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
        SIGNUPS_ALLOWED = false;
        DOMAIN = "https://vaultwarden.kurnousal.net";
      };
    };
  };
}
