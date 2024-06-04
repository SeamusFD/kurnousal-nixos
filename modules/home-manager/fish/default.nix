{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    functions = {
      fish_greeting = {
        body = "eval pfetch";
      };
    };
    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "hydro";
        src = pkgs.fishPlugins.hydro.src;
      }
      {
        name = "forgit";
        src = pkgs.fishPlugins.forgit.src;
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf.src;
      }
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "fifc";
        src = pkgs.fishPlugins.fifc.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
    ];
  };
  programs.zoxide.enable = true;
}
