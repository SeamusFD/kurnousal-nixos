{ pkgs, ... }:
{
  programs = {
    terminal.kitty.enable = true;
    terminal.starship.enable = true;
  };
  home.stateVersion = "24.05";
}
