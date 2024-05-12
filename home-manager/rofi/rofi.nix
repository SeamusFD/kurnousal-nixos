{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "kitty";
    theme = "/etc/nixos/kurnousal-nixos/home-manager/rofi/config.rasi";
  };
}
