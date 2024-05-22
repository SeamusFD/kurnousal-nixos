{ pkgs, config, lib, ... }:
{
  options = {
    systemd-bootloader.enable = lib.mkEnableOption "enables systemd-bootloader";
  };

  config = lib.mkIf config.systemd-bootloader.enable {
    boot.loader.systemd-boot.enable = true;
    boot.systemd-boot.configurationLimit = 25;
    boot.loader.timeout = 5;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
