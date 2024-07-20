{ pkgs, modulesPath, ... }:
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
  users.users.bcampbell = {
    isNormalUser = true;
    home = "/home/bcampbell";
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKE0++FS6236ilBUK2jeGCO1pxDKUsW3OOCdg40hUi7q bcampbell@192.168.1.77"
    ];

  };
  system.stateVersion = "23.11";
}
