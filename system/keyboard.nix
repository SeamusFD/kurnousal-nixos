{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    qmk_hid
  ];
}
