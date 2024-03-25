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
        mod = "dock";
        exclusive = true;
        output = [
          "HDMI-A-1"
          "DP-3"
        ];
        modules-left = ["clock" "cpu" "temperature"];
        modules-center = ["hyprland/workspaces"];
        modules-right = ["network" "bluetooth" "pulseaudio" "pulseaudio#microphone" "tray"];
      };

      "pulseaudio" = {
        "format" = "{icon} {volume}%";
        "format-muted" = " Muted";
        "on-click" = "pamixer -t";
        "on-scroll-up" = "pamixer -i 5";
        "on-scroll-down" = "pamixer -d 5";
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
      "pulseaudio#microphone" = {
        "format" = "{format_source}";
        "format-source" = "Mic: {volume}%";
        "format-source-muted" = "Mic: Muted";
        "on-click" = "pamixer --default-source -t";
        "on-scroll-up" = "pamixer --default-source -i 5";
        "on-scroll-down" = "pamixer --default-source -d 5";
        "scroll-step" = 5;
      };
      "hyprland/workspaces" = {
        "disable-scroll" = true;
        "all-outputs" = true;
        "on-click" = "activate";
        "sort-by-number" = true;
        "format-icons" = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          "urgent" = "";
          "active" = "";
          "default" = "";
        };
        "persistent-workspaces" = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
          "6" = [];
          "7" = [];
          "8" = [];
          "9" = [];
          "10" = [];
        };
      };
      "tray" = {
        "icon-size" = 15;
        "spacing" = 10;
      };
      "clock" = {
        "format" = "{: %I:%M %p   %a, %b %e}";
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };
      "network" = {
        "format-wifi" = "  {signalStrength}%";
        "format-ethernet" = "{ipaddr}/{cidr} ";
        "tooltip-format" = "{essid} - {ifname} via {gwaddr} ";
        "format-linked" = "{ifname} (No IP) ";
        "format-disconnected" = "Disconnected ⚠";
        "format-alt" = "{ifname}:{essid} {ipaddr}/{cidr}";
      };
      "bluetooth" = {
        "format" = " {status}";
        "format-disabled" = "";
        "format-connected" = " {num_connections}";
        "tooltip-format" = "{device_alias}";
        "tooltip-format-connected" = " {device_enumerate}";
        "tooltip-format-enumerate-connected" = "{device_alias}";
      };
      "cpu" = {
        "interval" = 1;
        "format" = "{icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}";
        "format-icons" = [
          "<span color='#69ff94'>▁</span>"
          "<span color='#2aa9ff'>▂</span>"
          "<span color='#f8f8f2'>▃</span>"
          "<span color='#f8f8f2'>▄</span>"
          "<span color='#ffffa5'>▅</span>"
          "<span color='#ffffa5'>▆</span>"
          "<span color='#ff9977'>▇</span>"
          "<span color='#dd532e'>█</span>"
        ];
      };
    };
    style = builtins.readFile "/etc/nixos/kurnousal-nixos/home-manager/waybar/theme.css";
  };
}
