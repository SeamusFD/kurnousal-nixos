{
  config,
  lib,
  ...
}: {
  options = {
    programs.browser.arkenfox.enable = lib.mkEnableOption "Enables the Arkenfox config and the default profile with privacy extensions";
  };
  config = lib.mkIf config.programs.browser.arkenfox.enable {
    stylix.targets.firefox.enable = lib.mkIf config.rice.stylix.enable true;
    programs.firefox = {
      enable = true;
      arkenfox = {
        enable = true;
        version = "master";
      };

      profiles.Default.arkenfox = {
        enable = true;
      };
    };
  };
}
