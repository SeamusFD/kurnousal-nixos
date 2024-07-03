{ config, lib, ... }:
{
  options = {
    services.xserver.amd.enable = lib.mkEnableOption "Enables xserver's amd driver options";
  };
  config = lib.mkIf config.services.xserver.amd.enable {
    # Configure keymap in X11
    services.xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      videoDrivers = [ "amdgpu" ];
    };
  };
}
