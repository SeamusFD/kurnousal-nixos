{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.system.fonts;
in {
  options = {
    system.fonts = {
      globalDefaults.enable = lib.mkEnableOption "Enables the global font config with defaults";
      name = lib.mkOption {
        type = with lib.types; str;
        default = "CaskaydiaCove Nerd Font";
        description = "Global font name";
      };
      serif = lib.mkOption {
        type = with lib.types; str;
        default = "CaskaydiaCove Nerd Font";
        description = "Global font serif";
      };
      sansSerif = lib.mkOption {
        type = with lib.types; str;
        default = "CaskaydiaCove Nerd Font";
        description = "Global font sans-serif";
      };
      monospace = lib.mkOption {
        type = with lib.types; str;
        default = "CaskaydiaCove Nerd Font";
        description = "Global font monospace";
      };
      emoji = lib.mkOption {
        type = with lib.types; str;
        default = "Twitter Color Emoji";
        description = "Global font emoji";
      };
      packages = lib.mkOption {
        type = with lib.types; listOf package;
        default = with pkgs; [nerdfonts twitter-color-emoji];
        description = "List of font packages used in font config";
      };
    };
  };
  config = lib.mkIf cfg.globalDefaults.enable {
    fonts = {
      packages = cfg.packages;
      fontconfig.defaultFonts = {
        serif = [cfg.serif];
        sansSerif = [cfg.sansSerif];
        monospace = [cfg.monospace];
        emoji = [cfg.emoji];
      };
    };
  };
}
