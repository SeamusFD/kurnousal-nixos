{
  lib,
  config,
  ...
}: {
  options = {
    programs.terminal.starship.enable = lib.mkEnableOption "Enables Starship and it's default config";
  };
  config = lib.mkIf config.programs.terminal.starship.enable {
    programs.starship = {
      enable = true;
      settings = {
        format = ''
          [┌───────────────────❯](bold green)
          [│](bold green)$username$hostname$localip$shlvl$directory$git_branch$git_commit$git_state$git_metricss$git_status$package$c$cmake$cobol$daml$dart$dotnet$rust$golang$python$java$sudo$shell
          [└─❯ ](bold green)
        '';
        palette = "default";
        add_newline = false;
        # character = {
        #   success_symbol = "[[](green) ❯](maroon)";
        #   error_symbol = "[❯](red)";
        #   vimcmd_symbol = "[❮](green)";
        # };
        directory = {
          truncation_length = 4;
          style = "bold lavender";
          substitutions = {
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
          };
        };
        palettes.default = {
          rosewater = "#f5e0dc";
          flamingo = "#f2cdcd";
          pink = "#f5c2e7";
          mauve = "#cba6f7";
          red = "#f38ba8";
          maroon = "#eba0ac";
          peach = "#fab387";
          yellow = "#f9e2af";
          green = "#a6e3a1";
          teal = "#94e2d5";
          sky = "#89dceb";
          sapphire = "#74c7ec";
          blue = "#89b4fa";
          lavender = "#b4befe";
          text = "#cdd6f4";
          subtext1 = "#bac2de";
          subtext0 = "#a6adc8";
          overlay2 = "#9399b2";
          overlay1 = "#7f849c";
          overlay0 = "#6c7086";
          surface2 = "#585b70";
          surface1 = "#45475a";
          surface0 = "#313244";
          base = "#1e1e2e";
          mantle = "#181825";
          crust = "#11111b";
        };
      };
    };
  };
}
