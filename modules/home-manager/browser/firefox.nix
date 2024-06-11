{
  config,
  lib,
  ...
}: {
  options = {
    programs.arkenfox.enable = lib.mkEnableOption "Enables the Arkenfox config and the default profile with privacy extensions";
  };
  config = lib.mkIf config.programs.arkenfox.enable {
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
