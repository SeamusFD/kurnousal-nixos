{ config, lib, ... }: {
  options = {
    window-manager.services.notifications.dunst.enable = lib.mkEnableOption "Enables the Dunst notification service with default config";
  };
  config = lib.mkIf config.window-manager.services.notifications.dunst.enable {
    services.dunst.enable = true;
  };
}
