{ pkgs, config, lib, ... }:
{
  options = {
    gaming.discord.enable = lib.mkEnableOption "enables custom discord and it's subsequent services";
  };
  config = lib.mkIf config.gaming.discord.enable {
    environment.systemPackages = [
      (pkgs.discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
    ];
  };
}
