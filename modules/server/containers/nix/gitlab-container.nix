{ pkgs, config, lib, ... }:
let
  secrets-dir = /var/lib/sops-secret-handler;
in
{
  options = {
    server.containers.gitlab-container.enable = lib.mkEnableOption "Enables and sets up the Gitlab container";
  };
  config = lib.mkIf config.server.containers.gitlab-container.enable {
    services.gitlab = {
      enable = true;
      host = "gitlab.kurnousal.net";

      databasePasswordFile = "${secrets-dir}" + "/gitlab/dbPassword";
      initialRootPasswordFile = "${secrets-dir}" + "/gitlab/initialRootPassword";
      secrets = {
        secretFile = "${secrets-dir}" + "/gitlab/secrets/secretFile";
        otpFile = "${secrets-dir}" + "/gitlab/secrets/otpFile";
        dbFile = "${secrets-dir}" + "/gitlab/secrets/dbFile";
        jwsFile = pkgs.runCommand "oidcKeyBase" { } "${pkgs.openssl}/bin/openssl genrsa 2048 > $out";
      };
    };
    systemd.services.gitlab-backup.environment.BACKUP = "dump";
  };
}
