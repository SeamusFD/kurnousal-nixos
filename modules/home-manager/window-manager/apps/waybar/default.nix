{ config, lib, ... }: {
  options = {
    window-manager.apps.waybar.enable = lib.mkEnableOption "Enables the Waybar app withd default config";
  };
  config = lib.mkIf config.window-manager.apps.waybar.enable {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "bottom";
          height = 34;
          exclusive = true;
          output = [
            "DP-1"
          ];
          modules-left = [ "clock" "custom/weather" "cpu" "custom/gpu-usage" "memory" ];
          modules-center = [ "hyprland/workspaces" ];
          modules-right = [ "gamemode" "systemd-failed-units" "bluetooth" "network" "custom/pipewire" "tray" "custom/dunst" ];

          "custom/pipewire" = {
            "tooltip" = false;
            "max-length" = 6;
            "exec" = "/etc/nixos/kurnousal-nixos/scripts/audio/pipewire.sh";
            "on-click" = "pavucontrol";
            "on-click-right" = "qpwgraph";
          };
          "custom/weather" = {
            "exec" = "wttrbar --fahrenheit --location Collierville+Tennessee";
            "return-type" = "json";
            "format" = "{}°";
            "tooltip" = true;
            "interval" = 1800;
          };
          "hyprland/workspaces" = {
            "format" = "{name}";
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
              "1" = [ ];
              "2" = [ ];
            };
          };
          "tray" = {
            "icon-size" = 15;
            "spacing" = 10;
          };
          "clock" = {
            "format" = " {:%H:%M}";
            "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };
          "network" = {
            "format-wifi" = "  {signalStrength}%";
            "format-ethernet" = "{ipaddr}/{cidr} 󰈀";
            "tooltip-format" = "{essid} - {ifname} via {gwaddr} 󰈀";
            "format-linked" = "{ifname} (No IP) 󰈁";
            "format-disconnected" = "Disconnected 󰈂";
            "format-alt" = "{ifname}:{essid} {ipaddr}/{cidr}";
          };
          "bluetooth" = {
            "format" = " {status}";
            "on-click" = "blueman-manager";
            "format-disabled" = "";
            "format-connected" = " {num_connections}";
            "tooltip" = true;
            "tooltip-format" = "{device_alias}";
            "tooltip-format-connected" = " {device_enumerate}";
            "tooltip-format-enumerate-connected" = "{device_alias}";
          };
          "cpu" = {
            "interval" = 1;
            "format" = "  {icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}   {load}%/{usage}%";
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
          "temperature" = {
            # "thermal-zone" = 0;
            # "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input";
            # "critical-threshold" = 80;
            "format-critical" = "{temperatureC}°C ";
            "format" = "{temperatureC}°C ";
          };
          "custom/gpu-usage" = {
            "exec" = "cat /sys/class/hwmon/hwmon4/device/gpu_busy_percent";
            "format" = "󰢮 {}%";
            "return-type" = "";
            "interval" = 1;
          };
          "memory" = {
            "interval" = 5;
            "format" = "󰍛 {used:0.1f}G/{total:0.1f}G  󰳲 {percentage}%";
            "tooltip-format" = "󰳲 Mem. {percentage}%  󰍛 Avail. {avail:0.1f}G  󰯍 Swap. {swapUsed:0.1f}G/{swapTotal:0.1f}G";
          };
          "gamemode" = {
            "format" = "{glyph}";
            "format-alt" = "{glyph} {count}";
            "glyph" = "";
            "hide-not-running" = true;
            "use-icon" = true;
            "icon-name" = "nf-fa-gamepad";
            "icon-spacing" = 4;
            "icon-size" = 20;
            "tooltip" = true;
            "tooltip-format" = "Games running: {count}";
          };
          "custom/dunst" = {
            "return-type" = "json";
            "exec" = "/etc/nixos/kurnousal-nixos/scripts/notifications/dunst.sh";
            "on-click" = "dunstctl set-paused toggle";
            "restart-interval" = 1;
          };
          "systemd-failed-units" = {
            "hide-on-ok" = false;
            "format" = "✗ {nr_failed}";
            "format-ok" = "✓";
            "system" = true;
            "user" = false;
          };
        };
      };
      style = builtins.readFile (./. + "/theme.css");
    };
  };
}
