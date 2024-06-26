{ pkgs, config, lib, ... }:
{
  options = {
    programs.file-manager.dolphin.enable = lib.mkEnableOption "Enable the Dolphin file manager and default config";
  };
  config = lib.mkIf config.programs.file-manager.dolphin.enable {
    home.packages = with pkgs; [
      libsForQt5.dolphin
    ];
  };
}
