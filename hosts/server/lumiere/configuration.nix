{ config, inputs, modulesPath, ... }:
{
  imports = [
    ../../common/nix-defaults
    ../../common/server-defaults

    inputs.sops-nix.nixosModules.sops

    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/etc/sops/age/keys.txt";

  sops.secrets.dreamhost-api-key = {
    owner = "sops-secret-handler";
  };

  systemd.services."sops-secret-handler" = {
    enable = true;
    script = ''
      cat ${config.sops.secrets.dreamhost-api-key.path} > /var/lib/sops-secret-handler/dreamhost-api-key
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

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  disko.devices.disk.disk1.device = "/dev/sda";

  services.network-conf = {
    enable = true;
    hostName = "lumiere";
  };

  environment.internationalisation.timezone.enable = true;

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC+XfQLulR+OLpJ3PkN14iu/am0SDxCLlePGoxL027+k root@lumiere"
  ];
  users.users.lumiere = {
    isNormalUser = true;
    home = "/home/lumiere";
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKE0++FS6236ilBUK2jeGCO1pxDKUsW3OOCdg40hUi7q bcampbell@192.168.1.77"
    ];

  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.lumiere = ./home.nix;
  home-manager.extraSpecialArgs = {
    inherit inputs;
  };
  home-manager.sharedModules = [
    inputs.self.outputs.homeManagerModules.default
    inputs.self.inputs.nur.hmModules.nur
    inputs.self.inputs.arkenfox.hmModules.arkenfox
    inputs.self.inputs.stylix.homeManagerModules.stylix
  ];

  # Server config from modules
  server = {
    proxy = {
      nginx.enable = true;
    };
    containers = {
      docker.enable = true;
      jellyfin-container.enable = true;
      # vaultwarden-container.enable = true;
    };
    networking = {
      defaults.enable = true;
    };
  };

  system.stateVersion = "23.11";
}
