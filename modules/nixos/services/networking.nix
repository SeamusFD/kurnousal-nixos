{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    network-conf.enable = lib.mkEnableOption "enables usage of network-conf";
    network-conf.hostName = lib.mkOption {
      default = "nixos";
    };
  };

  config = lib.mkIf config.network-conf.enable {
    networking.hostName = config.network-conf.hostName;
    networking.hosts = {
      # Testing
      "127.0.0.1" = ["localhost"];
    };
    networking.useDHCP = lib.mkForce true;
    networking.networkmanager.enable = true;
  };
}
