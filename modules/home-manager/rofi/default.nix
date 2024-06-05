{ pkgs
, lib
, ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "kitty";
    theme = lib.mkForce (./. + "/config.rasi");
  };
}
