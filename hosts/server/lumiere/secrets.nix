{ config, inputs, ... }: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/etc/sops/age/keys.txt";

  sops.secrets."lumiere/ssl/acme/dreamhost-api-key" =
    { owner = "sops-secret-handler"; };
  sops.secrets."lumiere/containers/gitlab/dbPassword" =
    { owner = "sops-secret-handler"; };
  sops.secrets."lumiere/containers/gitlab/initialRootPassword" =
    { owner = "sops-secret-handler"; };
  sops.secrets."lumiere/containers/gitlab/secrets/secretFile" =
    { owner = "sops-secret-handler"; };
  sops.secrets."lumiere/containers/gitlab/secrets/otpFile" =
    { owner = "sops-secret-handler"; };
  sops.secrets."lumiere/containers/gitlab/secrets/dbFile" =
    { owner = "sops-secret-handler"; };

  systemd.services."sops-secret-handler" = {
    enable = true;
    script = ''
      cat ${config.sops.secrets."lumiere/ssl/acme/dreamhost-api-key".path} > /var/lib/sops-secret-handler/dreamhost-api-key
      cat ${config.sops.secrets."lumiere/containers/gitlab/dbPassword".path} > /var/lib/sops-secret-handler/gitlab/dbPassword
      cat ${config.sops.secrets."lumiere/containers/gitlab/dbPassword".path} > /var/lib/sops-secret-handler/gitlab/initialRootPassword
      cat ${config.sops.secrets."lumiere/containers/gitlab/dbPassword".path} > /var/lib/sops-secret-handler/gitlab/secrets/secretFile
      cat ${config.sops.secrets."lumiere/containers/gitlab/dbPassword".path} > /var/lib/sops-secret-handler/gitlab/secrets/otpFile
      cat ${config.sops.secrets."lumiere/containers/gitlab/dbPassword".path} > /var/lib/sops-secret-handler/gitlab/secrets/dbFile
    '';
    serviceConfig = {
      User = "sops-secret-handler";
      WorkingDirectory = "/var/lib/sops-secret-handler";
    };
  };

  users.users.sops-secret-handler = {
    home = "/var/lib/sops-secret-handler";
    createHome = true;
    isSystemUser = true;
    group = "sops-secret-handler";
  };
  users.groups.sops-secret-handler = { };
}
