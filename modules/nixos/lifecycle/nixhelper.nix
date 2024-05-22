{ pkgs, config, lib, ... }:
{
  options = {
   nh.enable = lib.mkEnableOption "enable nix helper";
  };
  config = lib.mkIf config.nh.enable {
    environment.systemPackages = with pkgs; [
      nh
    ];
  };
}
