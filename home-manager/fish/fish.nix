{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    functions = {
      fish_greeting = {
        body = "eval pfetch";
      };
    };
  };
}
