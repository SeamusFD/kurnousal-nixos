{
  config,
  pkgs,
  ...
}: {
  services.xserver.displayManager = {
    session = [
      {
        manage = "desktop";
        name = "hyprland";
        start = "Hyprland";
      }
    ];
  };
  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland = {
      enable = true;
    };
    settings = {
      AutoLogin = {
        Session = "hyprland.desktop";
        User = "benjaminc";
      };
    };
  };
}
