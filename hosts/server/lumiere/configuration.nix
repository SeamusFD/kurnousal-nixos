{ inputs, pkgs, modulesPath, ... }:
{
  imports = [
    ../../common/nix-defaults/nix-features.nix
    ../../common/nix-defaults/nix-garbage-collection.nix

    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  disko.devices.disk.disk1.device = "/dev/sda";

  services.network-conf = {
    enable = true;
    hostName = "lumiere";
  };

  environment.systemPackages = with pkgs; [ vim ];

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

  system.stateVersion = "23.11";
}
