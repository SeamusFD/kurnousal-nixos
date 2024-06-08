{ pkgs
, lib
, ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "kitty";
    extraConfig = {
      modi = "drun,run,filebrowser,window,ssh";
      icon-theme = "Papirus-dark";
      show-icons = true;
      terminal = "kitty";

      run-categories = "";
      drun-match-fields = "name,generic,exec,categories,keywords";
      drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
      drun-show-actions = false;
      drun-url-launcher = "xdg-open";
      drun-use-desktop-cache = false;
      drun-reload-desktop-cache = false;
      # drun = {
      #   parse-user = true;
      #   parse-system = true;
      # };
      run-command = "{cmd}";
      run-list-command = "";
      run-shell-command = "{terminal} -e {cmd}";

      window-match-fields = "title,class,role,name,desktop";
      window-format = "{w} - {c} - {t:0}";
      window-thumbnail = false;

      location = 0;
      disable-history = false;
      case-sensitive = false;
      hide-scrollbar = true;
      click-to-exit = true;
      display-drun = "   Apps ";
      display-run = "   Run";
      display-ssh = " 󱕁  SSH";
      display-filebrowser = "   Files";
      display-window = "   Windows";
      sidebar-mode = true;

      kb-primary-paste = "Control+V";
      kb-primary-copy = "Control+C";
      kb-mode-next = "Shift+Right";
      kb-mode-previous = "Shift+Left";
      kb-mode-complete = "Control+l";
    };
    theme = (./. + "/themes/catppuccin-mocha.rasi");
  };
}
