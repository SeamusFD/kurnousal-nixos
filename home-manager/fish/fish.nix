{pkgs, ...}: {
  programs.fish = {
    enable = true;
    functions = {
      fish_greeting = {
        body = "eval pfetch";
      };
    };
  };
  programs.zoxide.enable = true;
}
