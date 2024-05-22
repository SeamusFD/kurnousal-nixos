{ pkgs, lib, ... }:
{
  imports = [
    (./. + "/fish")
    (./. + "/hyprland")
    (./. + "/kitty")
    (./. + "/nixvim")
    (./. + "/rofi")
    (./. + "/waybar")
    (./. + "/xserver")
  ];
}
