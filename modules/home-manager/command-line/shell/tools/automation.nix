{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    command-line.shell.tools.automation.enable = lib.mkEnableOption "Enables the automation packages";
  };
  config = lib.mkIf config.command-line.shell.tools.automation.enable {
    home.packages = with pkgs; [
      ansible
      ansible-doctor
      ansible-builder
    ];
  };
}
