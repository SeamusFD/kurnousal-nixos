{
  config,
  lib,
  ...
}: {
  options = {
    programs.terminal.kitty.enable = lib.mkEnableOption "Enables the kitty terminal with it's default config";
  };
  config = lib.mkIf config.programs.terminal.kitty.enable {
    stylix.targets.kitty.enable = lib.mkIf config.rice.stylix.enable true;
    programs.kitty = {
      enable = true;
      settings = {
        active_tab_font_style = "bold";
        cursor_shape = "underline";
        cursor_stop_blinking_after = 0;
        cursor_underline_thickness = "1.5";
        disable_ligatures = "never";
        font_family = "CaskaydiaCove Nerd Font Mono";
        bold_font = "auto";
        italic_font = "auto";
        bell_on_tab = "🔔 ";
        editor = "nvim";

        font_size = 13;
        window_margin_width = 0;
        window_padding_width = 20;
        confirm_os_window_close = 0;
        hide_window_decorations = "titlebar-only";
        inactive_tab_font_style = "normal";
        inactive_text_alpha = "1.0";
        placement_strategy = "center";
        resize_in_steps = "yes";
        scrollback_lines = 10000;
        tab_bar_edge = "bottom";
        tab_bar_min_tabs = 1;
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
        touch_scroll_multiplier = "1.0";
        wheel_scroll_multiplier = "5.0";
      };
      shellIntegration.enableFishIntegration = true;
      extraConfig = builtins.readFile ./colorschemes/catppuccin/mocha.conf;
    };
  };
}
