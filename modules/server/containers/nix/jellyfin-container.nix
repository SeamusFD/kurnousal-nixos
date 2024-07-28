{ config, lib, ... }:
{
  options = {
    server.containers.jellyfin-container.enable = lib.mkEnableOption "Enables and sets up the Jellyfin container";
  };
  config = lib.mkIf config.server.containers.jellyfin-container.enable {
    services.jellyfin = {
      enable = true;
      dataDir = "/media/jellyfin/data";
      group = "jellyfin";
      user = "jellyfin";
      openFirewall = true;
    };
  };
}
