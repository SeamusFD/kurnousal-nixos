{
  pkgs,
  config,
  ...
}: {
  programs.rofi = {
    enable = true;
    configPath = "$XDG_CONFIG_HOME/rofi/config.rasi";
    extraConfig = ''
      // Config //
      configuration {
          modi:                        "drun,filebrowser,window,run";
          show-icons:                  true;
          display-drun:                "";
          display-run:                 "";
          display-filebrowser:         "";
          display-window:              "";
          drun-display-format:         "{name}";
          window-format:               "{w}{t}";
          font:                        "JetBrainsMono Nerd Font 10";
          icon-theme:                  "Tela-circle-dracula";
      }

      @theme "/etc/nixos/kurnousal-nixos/home-manager/rofi/themes/theme.rasi"

      // Main //
      window {
          height:                      590px;
          width:                       1140px;
          transparency:                "real";
          fullscreen:                  false;
          enabled:                     true;
          cursor:                      "default";
          spacing:                     0px;
          padding:                     0px;
          border:                      2px;
          border-radius:               40px;
          border-color:                @main-br;
          background-color:            transparent;
      }
      mainbox {
          enabled:                     true;
          spacing:                     0px;
          orientation:                 horizontal;
          children:                    [  "inputbar" , "listbox" ];
          background-color:            transparent;
          background-image:            url("~/.config/swww/wall.blur", height);
      }


      // Inputs //
      inputbar {
          enabled:                     true;
          width:                       640px;
          children:                    [ "mode-switcher" , "entry" ];
          background-color:            transparent;
          background-image:            url("~/.config/swww/wall.rofi", height);
      }
      entry {
          enabled:                     false;
      }


      // Modes //
      mode-switcher{
          orientation:                 vertical;
          enabled:                     true;
          spacing:                     0px;
          width:                       68px;
          padding:                     160px 10px 160px 10px;
          spacing:                     25px;
          background-color:            transparent;
          background-image:            url("~/.config/swww/wall.blur", height);
      }
      button {
          cursor:                      pointer;
          vertical-align:              0.50;
          horizontal-align:            0.45;
          border-radius:               50px;
          background-color:            @main-bg;
          text-color:                  @main-fg;
      }
      button selected {
          background-color:            @main-fg;
          text-color:                  @main-bg;
      }


      // Lists //
      listbox {
          spacing:                     10px;
          padding:                     30px;
          children:                    [ "listview" ];
          background-color:            @main-bg;
      }
      listview {
          enabled:                     true;
          columns:                     1;
          cycle:                       true;
          dynamic:                     true;
          scrollbar:                   false;
          layout:                      vertical;
          reverse:                     false;
          fixed-height:                true;
          fixed-columns:               true;
          cursor:                      "default";
          background-color:            transparent;
          text-color:                  @main-fg;
      }


      // Elements //
      element {
          enabled:                     true;
          spacing:                     30px;
          padding:                     8px;
          border-radius:               20px;
          cursor:                      pointer;
          background-color:            transparent;
          text-color:                  @main-fg;
      }
      @media(max-aspect-ratio: 1.8) {
          element {
              orientation:             vertical;
          }
      }
      element selected.normal {
          background-color:            @select-bg;
          text-color:                  @select-fg;
      }
      element-icon {
          size:                        48px;
          cursor:                      inherit;
          background-color:            transparent;
          text-color:                  inherit;
      }
      element-text {
          vertical-align:              0.5;
          horizontal-align:            0.0;
          cursor:                      inherit;
          background-color:            transparent;
          text-color:                  inherit;
      }
    '';
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
