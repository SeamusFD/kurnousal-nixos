{ pkgs, config, lib, ...}:
{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    package = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          libkrb5
          keyutils
        ];
    };
  };
  programs.gamemode.enable = true;
}
