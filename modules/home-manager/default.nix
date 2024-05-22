{ pkgs, lib, ... }:
{
  imports = [
    (./. + "/fish")
    (./. + "/hyprland")
    (./. + "/kitty")
    (./. + "/neovim")
    (./. + "/rofi")
    (./. + "/waybar")
    (./. + "/xserver")
  ];
}
