{ pkgs, config, lib, ... }:
{
  options = {
    services.login.sddm.enable = lib.mkEnableOption "Enables the SDDM login greeter";
  };

  config = lib.mkIf config.services.login.sddm.enable {
    services.displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "${import ./themes/sugar-catppuccin-theme.nix { inherit pkgs; }}";
      };
    };
  };
}
