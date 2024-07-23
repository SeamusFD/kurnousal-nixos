{ config, lib, ... }:
let
  cfg = config.server.networking;
in
{
  imports = [
    ./network-manager.nix
    ./firewall.nix
  ];

  options = {
    server.networking.defaults.enable = lib.mkEnableOption "Enables all the default options of the networking section on the server";
  };

  config = lib.mkIf cfg.defaults.enable {
    server.networking.network-manager.enable = true;
    server.networking.firewall.enable = true;
  };
}
