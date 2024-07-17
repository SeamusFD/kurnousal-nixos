{
  lib,
  config,
  ...
}: {
  options = {
    services.network-conf.enable = lib.mkEnableOption "enables usage of network-conf";
    services.network-conf.hostName = lib.mkOption {
      default = "nixos";
    };
  };

  config = lib.mkIf config.services.network-conf.enable {
    networking.hostName = config.services.network-conf.hostName;
    networking.hosts = {
      # Testing
      "127.0.0.1" = ["localhost"];
    };
    networking.useDHCP = lib.mkForce true;
    networking.networkmanager.enable = true;
  };
}
