{
  pkgs,
  config,
  ...
}: {
  programs.rofi = {
    enable = true;
    configPath = "$XDG_CONFIG_HOME/rofi/config.rasi";
    theme = "/etc/nixos/kurnousal-nixos/home-manager/rofi/themes/Catppuccin-Mocha.rasi";
    font = "CaskaydiaCove NerdFont";
    plugins = with pkgs; [
      rofimoji
      rofi-calc
      rofi-rbw
      rofi-vpn
      rofi-systemd
    ];
  };
}
