{ pkgs, lib, config, ... }:
{
  options = {
    window-manager.services.xorg.utils.enable = lib.mkEnableOption "Enables the xorg utils (for both wayland and xserver)";
  };
  config = lib.mkIf config.window-manager.services.xorg.utils.enable {
    home.packages = with pkgs; [
      xorg.xrandr
    ];
  };
}
