{ config, lib, ... }:
{
  options = {
    server.networking.firewall.enable = lib.mkEnableOption "Enables the default firewall rules for the server";
  };
  config = lib.mkIf config.server.networking.firewall.enable {
    networking = {
      firewall.enable = true;
      nftables.enable = true;
      firewall.allowedTCPPorts = [ 53 80 443 ];
      firewall.allowedUDPPortRanges = [
        { from = 4000; to = 4007; }
        { from = 8000; to = 8010; }
      ];
    };
  };
}
