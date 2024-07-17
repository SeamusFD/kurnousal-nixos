{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    programs.game-dev.godot.enable = lib.mkEnableOption "Enables Godot4 and it's default config";
  };
  config = lib.mkIf config.programs.game-dev.godot.enable {
    home.packages = [
      pkgs.godot_4
    ];
  };
}
