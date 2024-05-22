{ pkgs, config, lib, ... }:
{
  options = {
    super-user.enable = lib.mkEnableOption "enable administrator user module";
    super-user.userName = lib.mkOption {
      default = "bcampbell";
      description = ''
        username
      '';
    };
  };

  config = lib.mkIf config.super-user.enable {
    users.users.${config.super-user.userName} = {
      isNormalUser = true;
      description = "super user";
      extraGroups = ["networkmanager" "wheel" "gamemode" "libvirtd"];
    };
  };
}
