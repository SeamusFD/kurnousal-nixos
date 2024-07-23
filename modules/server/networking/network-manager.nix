{ config, lib, ... }:
let
  cfg = config.server.networking.network-manager;
in
{
  options = {
    server.networking.network-manager.enable = lib.mkEnableOption "Enables the server network manager with default config";
  };
  config = lib.mkIf cfg.enable {
    networking = {
      # Add more granularity to the network manager in the future
      networkmanager = {
        enable = true;
        insertNameservers = [
          "ns1.dreamhost.com"
          "ns2.dreamhost.com"
          "ns3.dreamhost.com"
        ];
      };
    };
  };
}
