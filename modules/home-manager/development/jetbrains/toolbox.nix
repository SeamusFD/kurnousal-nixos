{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.development.jetbrains.toolbox;
in {
  options = {
    development.jetbrains.toolbox.enable = lib.mkEnableOption "Enables the jetbrains toolbox with default config";
  };
  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "jetbrains-toolbox"
      ];
    home.packages = with pkgs; [
      jetbrains-toolbox
    ];
  };
}
