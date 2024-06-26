{ config
, lib
, ...
}: {
  options = {
    services.bootloader.systemd-bootloader.enable = lib.mkEnableOption "enables systemd-bootloader";
  };

  config = lib.mkIf config.services.bootloader.systemd-bootloader.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 25;
    boot.loader.timeout = 5;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
