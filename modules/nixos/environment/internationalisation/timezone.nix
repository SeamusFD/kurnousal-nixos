{
  config,
  lib,
  ...
}: {
  options = {
    environment.internationalisation.timezone.enable = lib.mkEnableOption "Enables the internationalisation options with a default config";
  };
  config = lib.mkIf config.environment.internationalisation.timezone.enable {
    # Set your time zone.
    time.timeZone = "America/Chicago";
  };
}
