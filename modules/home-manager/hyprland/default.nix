{ pkgs, inputs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    extraConfig = ''
      monitor=HDMI-A-1,2560x1440@144,0x0,1
      monitor=DP-3,1920x1080@120,2560x0,1
      exec-once = waybar & dunst & swww-daemon
      exec-once = set-primary-monitor
      exec-once = hyprctl setcursor Bibata-Modern-Ice 7

      env = GDK_BACKEND,wayland,x11
      env = QT_QPA_PLATFORM,wayland;xcb
      env = SLD_VIDEODRIVER,wayland
      env = CLUTTER_BACKEND,wayland
      env = HYPRCURSOR_THEME,Bibata-Modern-Ice
      env = HYPRCURSOR_SIZE,7
      env = XCURSOR_SIZE,7

      workspace=1,monitor:HDMI-A-1
      workspace=2,monitor:DP-3

      $scrPath = /etc/nixos/kurnousal-nixos/modules/lib/scripts

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

      dwindle {
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
      }

      master {
          new_is_master = true
      }

      gestures {
          workspace_swipe = off
      }

      source = /etc/nixos/kurnousal-nixos/modules/home-manager/hyprland/conf/keybindings.conf
      source = /etc/nixos/kurnousal-nixos/modules/home-manager/hyprland/conf/window_decorations.conf
      source = /etc/nixos/kurnousal-nixos/modules/home-manager/hyprland/conf/window_rules.conf
    '';
  };
}
