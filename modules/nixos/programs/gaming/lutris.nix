{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    programs.gaming.lutris.enable = lib.mkEnableOption "Enables the Lutris game launcher with default options";
  };
  config = lib.mkIf config.programs.gaming.lutris.enable {
    environment.systemPackages = with pkgs; [
      lutris
    ];
  };
}
