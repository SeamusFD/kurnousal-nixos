{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    window-manager.services.wallpaper.enable = lib.mkEnableOption "Enables wallpaper managerment services";
  };
  config = {
    home.packages = with pkgs; [swww];
  };
}
