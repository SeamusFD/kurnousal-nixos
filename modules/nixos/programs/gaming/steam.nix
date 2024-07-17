{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    programs.gaming.steam.enable = lib.mkEnableOption "Enables Steam with a default config of Gamescope and Gamemode";
  };
  config = lib.mkIf config.programs.gaming.steam.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            libkrb5
            keyutils
          ];
      };
    };
    programs.gamemode.enable = true;
    environment.systemPackages = with pkgs; [protonup-qt er-patcher];
  };
}
