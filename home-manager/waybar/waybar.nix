{
  pkgs,
  config,
  ...
}:
with builtins; {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "HDMI-A-1"
          "DP-3"
        ];
        modules-left = [];
        modules-center = [];
        modules-right = ["pulseaudio"];
      };

      "pulseaudio" = {
        "format" = "{icon} {volume}";
        "rotate" = 0;
        "format-muted" = "婢";
        "on-click" = "pavucontrol -t 3";
        "on-click-middle" = "~/.config/hyprdots/scripts/volumecontrol.sh -o m";
        "on-scroll-up" = "~/.config/hyprdots/scripts/volumecontrol.sh -o i";
        "on-scroll-down" = "~/.config/hyprdots/scripts/volumecontrol.sh -o d";
        "tooltip-format" = "{icon} {desc} // {volume}%";
        "scroll-step" = 5;
        "format-icons" = {
          "headphone" = "";
          "hands-free" = "";
          "headset" = "";
          "phone" = "";
          "portable" = "";
          "car" = "";
          "default" = ["" "" ""];
        };
      };
    };
    style = builtins.readFile "/etc/nixos/kurnousal-nixos/home-manager/waybar/theme.css";
  };
}
