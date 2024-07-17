{
  lib,
  config,
  ...
}: {
  options = {
    environment.internationalisation.locale.enable = lib.mkEnableOption "Enables the default locale options";
    environment.internationalisation.locale.type = lib.mkOption {
      default = "en_US.UTF-8";
      description = ''
        Sets the two part locale type with the first part being
        then international locale, then the file encoding type.
      '';
    };
  };
  config = lib.mkIf config.environment.internationalisation.locale.enable {
    # Select internationalisation properties.
    i18n.defaultLocale = config.environment.locale.type;
    i18n.extraLocaleSettings = {
      LC_ADDRESS = config.environment.locale.type;
      LC_IDENTIFICATION = config.environment.locale.type;
      LC_MEASUREMENT = config.environment.locale.type;
      LC_MONETARY = config.environment.locale.type;
      LC_NAME = config.environment.locale.type;
      LC_NUMERIC = config.environment.locale.type;
      LC_PAPER = config.environment.locale.type;
      LC_TELEPHONE = config.environment.locale.type;
      LC_TIME = config.environment.locale.type;
    };
  };
}
