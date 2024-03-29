{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Bluetooth modules
    bluez
    bluez-tools
    bluez-alsa
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.blueman.enable = true;
}
