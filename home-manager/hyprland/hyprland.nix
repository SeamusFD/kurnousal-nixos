{
  config,
  inputs,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      monitor=HDMI-A-1,2560x1440@144,0x0,1
      monitor=DP-3,1920x1080@120,2560x0,1
      exec-once = waybar & hyprpaper
      exec-once = swww init
      $scrPath = ~/.config/hypr/scripts

      env = XCURSOR_SIZE,24

      workspace=1,monitor:HDMI-A-1
      workspace=2,monitor:DP-3

      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          sensitivity = 0.35
          accel_profile = flat

          touchpad {
              natural_scroll = no
          }
      }

      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 5
          gaps_out = 20
          border_size = 2
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)

          layout = dwindle

          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
      }

      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = off
      }

      misc {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          force_default_wallpaper = -1 # Set to 0 to disable the anime mascot wallpapers

      source = /etc/nixos/kurnousal-nixos/home-manager/hyprland/conf/keybindings.conf
      source = /etc/nixos/kurnousal-nixos/home-manager/hyprland/conf/window_decorations.conf
      source = /etc/nixos/kurnousal-nixos/home-manager/hyprland/conf/window_rules.conf
    '';
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-kde
    xdg-desktop-portal-hyprland
  ];
  xdg.portal.configPackages = with pkgs; [
    xdg-desktop-portal-kde
    xdg-desktop-portal-hyprland
  ];
}
