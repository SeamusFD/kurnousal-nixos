{
  pkgs,
  config,
  ...
}: {
  programs.rofi = {
    enable = true;
    theme = "/etc/nixos/kurnousal-nixos/home-manager/rofi/themes/Catppuccin-Mocha.rasi";
  };
}
