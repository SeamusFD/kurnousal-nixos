{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.rofi = {
    enable = true;
    terminal = "kitty";

    extraConfig = {
      modi = "drun";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      sidebar-mode = true;
    };
  };
}
