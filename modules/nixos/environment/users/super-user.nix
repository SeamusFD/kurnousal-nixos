{
  config,
  lib,
  ...
}: {
  options = {
    environment.super-user.enable = lib.mkEnableOption "enable administrator user module";
    environment.super-user.userName = lib.mkOption {
      default = "bcampbell";
      description = ''
        username
      '';
    };
  };

  config = lib.mkIf config.environment.super-user.enable {
    users.users.${config.environment.super-user.userName} = {
      isNormalUser = true;
      description = "super user";
      extraGroups = ["networkmanager" "wheel" "gamemode" "libvirtd"];
    };
  };
}
