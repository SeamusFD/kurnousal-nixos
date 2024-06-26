{ lib, ... }: {
  # This determines our default non home-manager nix configurations. This is present across all machines unless edited by the specific machine config.
  imports = [
    (./. + "/services/bootloader.nix")
    (./. + "/services/networking.nix")
    (./. + "/environment/session-variables.nix")
    (./. + "/environment/super-user.nix")
    (./. + "/environment/bash-scripts.nix")
    (./. + "/gaming/steam.nix")
    (./. + "/gaming/discord.nix")
    (./. + "/lifecycle/nixhelper.nix")
    (./. + "/peripherals/bluetooth.nix")
    (./. + "/peripherals/keyboard.nix")
    # Folder default imports
    (./. + "/development")
  ];
  # Enable the nix helper shell
  services.bootloader.systemd-bootloader.enable = lib.mkDefault true;
  services.network-conf.enable = lib.mkDefault true;
  super-user.enable = lib.mkDefault true;
}
