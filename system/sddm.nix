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
  services.xserver.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland = {
      enable = true;
      compositorCommand = "Hyprland";
    };
    settings = {
      AutoLogin = {
        Session = "hyprland.desktop";
        User = "benjaminc";
      };
    };
  };
}
