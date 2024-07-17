{
  config,
  lib,
  ...
}: {
  options = {
    programs.terminal.monitoring.btop.enable = lib.mkEnableOption "Enables the btop monitoring tool with it's default config";
  };
  config = lib.mkIf config.programs.terminal.monitoring.btop.enable {
    stylix.targets.btop.enable = lib.mkIf config.rice.stylix.enable true;
    programs.btop.enable = true;
  };
}
