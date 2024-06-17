{ pkgs, config, lib, ... }:
{
  options = {
    programs.music.tidal.enable = lib.mkEnableOption "Enables the music streaming app Tidal with it's default config";
  };
  config = lib.mkIf config.programs.music.tidal.enable {
    home.packages = with pkgs; [ tidal-hifi ];
  };
}
