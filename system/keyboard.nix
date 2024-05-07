{
  config,
  pkgs,
  ...
}: {
  hardware.keyboard.qmk.enable = true;
  environment.systemPackages = with pkgs; [
    qmk
    qmk-udev-rules
    qmk_hid
  ];
}
