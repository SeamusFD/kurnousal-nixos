{
  config,
  lib,
  ...
}: {
  options = {
    window-manager.services.notifications.dunst.enable = lib.mkEnableOption "Enables the Dunst notification service with default config";
  };
  config = lib.mkIf config.window-manager.services.notifications.dunst.enable {
    stylix.targets.dunst.enable = lib.mkIf config.rice.stylix.enable true;
    services.dunst.enable = true;
  };
}
