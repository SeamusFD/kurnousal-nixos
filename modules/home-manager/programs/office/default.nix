{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    programs.office.libre-office.enable = lib.mkEnableOption "Enables the Libre Office suite with default config";
  };
  config = lib.mkIf config.programs.office.libre-office.enable {
    home.packages = with pkgs; [
      libreoffice-qt
    ];
  };
}
