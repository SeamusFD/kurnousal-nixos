{ pkgs, lib, ... }:
{
  imports = [
    (./. + "/fish")
    (./. + "/hyprland")
    (./. + "/kitty")
    (./. + "/rofi")
    (./. + "/waybar")
    (./. + "/xserver")
  ];
}
