{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    xorg.xrandr
  ];
}
