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
}
