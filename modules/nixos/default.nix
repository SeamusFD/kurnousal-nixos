{ lib, ... }: {
  # This determines our default non home-manager nix configurations. This is present across all machines unless edited by the specific machine config.
  imports = [
    # Folder default imports
    ./services
    ./lifecycle
    ./environment
    ./development
    ./programs
    ./peripherals
  ];
  # Enable the nix helper shell
  services.bootloader.systemd-bootloader.enable = lib.mkDefault true;
  services.network-conf.enable = lib.mkDefault true;
  environment.super-user.enable = lib.mkDefault true;
}
