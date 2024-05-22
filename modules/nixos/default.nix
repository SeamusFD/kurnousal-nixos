{ pkgs, lib, ... }:
{
# This determines our default non home-manager nix configurations. This is present across all machines unless edited by the specific machine config.
  imports = [
    (./. + "/services/bootloader.nix")
    (./. + "/services/networking.nix")
    (./. + "/services/monitoring.nix")
    (./. + "/environment/session-variables.nix")
    (./. + "/environment/super-user.nix")
    (./. + "/lifecycle/nixhelper.nix")
    (./. + "/peripherals/bluetooth.nix")
    (./. + "/peripherals/keyboard.nix")
    # Folder default imports
    (./. + "/development")
  ];
  # Enable the nix helper shell
  nh.enable = lib.mkDefault true;
  systemd-bootloader.enable = lib.mkDefault true;
  network-conf.enable = lib.mkDefault true;
  super-user.enable = lib.mkDefault true;
}
