{ config, lib, ... }:
{
  options = {
    programs.terminal.kitty.enable = lib.mkEnableOption "Enables the kitty terminal with it's default config";
  };
  config = lib.mkIf config.programs.terminal.kitty.enable {
    programs.kitty = {
      enable = true;
      settings = {
        cursor_shape = "beam";
        font_family = "CaskaydiaCove Nerd Font Mono";
        bold_font = "auto";
        italic_font = "auto";
        bell_on_tab = "🔔 ";

        font_size = 11;
        window_padding_width = 25;
        confirm_os_window_close = 0;
        hide_window_decorations = true;
      };
      shellIntegration.enableFishIntegration = true;
      extraConfig = builtins.readFile ./colorschemes/catppuccin/mocha.conf;
    };
  };
}
