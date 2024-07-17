{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    services.sound.enable = lib.mkEnableOption "Enables the default sound options";
  };
  config = lib.mkIf config.services.sound.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    environment.systemPackages = with pkgs; [
      pavucontrol
      qpwgraph
    ];
  };
}
