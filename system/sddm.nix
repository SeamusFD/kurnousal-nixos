{
  config,
  pkgs,
  ...
}: {
  services.xserver.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland = {
      enable = true;
    };
    settings = {
      AutoLogin = {
        Session = "Hyprland";
        User = "benjaminc";
      };
    };
  };
}
