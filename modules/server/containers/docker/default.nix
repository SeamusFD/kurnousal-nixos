{ config, lib, ... }:
{
  options = {
    server.containers.docker.enable = lib.mkEnableOption "Enables docker virtualisation";
  };
  config = lib.mkIf config.server.containers.docker.enable {
    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
    };
    virtualisation.oci-containers.backend = "docker";
  };
}
