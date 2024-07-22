{ pkgs, ... }:
{
  programs = {
    terminal.kitty.enable = true;
    terminal.starship.enable = true;
  };
  command-line = {
    shell.fish.enable = true;
    shell.greeter = {
      enable = true;
      name = "fastfetch";
      package = pkgs.fastfetch;
    };
    shell.tools = {
      grep.enable = true;
      archive.enable = true;
    };
  };
  development = {
    vcs.git.enable = true;
  };
  home.stateVersion = "24.05";
}
