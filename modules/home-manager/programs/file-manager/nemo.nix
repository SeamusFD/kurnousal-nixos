{ pkgs, config, lib, ... }:
{
  options = {
    programs.file-manager.nemo.enable = lib.mkEnableOption "Enable the Nemo file manager and default config";
  };
  config = lib.mkIf config.programs.file-manager.nemo.enable {
    home.packages = [
      pkgs.cinnamon.nemo-with-extensions
    ];
  };
}
