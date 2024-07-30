{ pkgs
, config
, lib
, ...
}:
let
  cfg = config.command-line.shell;
  rice-cfg = config.rice.stylix;
in
{
  options = {
    command-line.shell.fish = {
      enable = lib.mkEnableOption "Enables fish shell with default config";
    };
  };
  config = lib.mkIf cfg.fish.enable {
    stylix.targets.fish.enable = lib.mkIf rice-cfg.enable true;
    stylix.targets.fzf.enable = lib.mkIf rice-cfg.enable true;
    programs.fish = {
      enable = true;
      functions = {
        fish_greeting = {
          body = "eval ${cfg.greeter.name}";
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
          name = "tide";
          src = pkgs.fishPlugins.tide.src;
        }
        {
          name = "pisces";
          src = pkgs.fishPlugins.pisces.src;
        }
        {
          name = "puffer";
          src = pkgs.fishPlugins.puffer.src;
        }
        {
          name = "git-abbr";
          src = pkgs.fishPlugins.git-abbr.src;
        }
        {
          name = "done";
          src = pkgs.fishPlugins.done.src;
        }
      ];
      shellInitLast = "direnv hook fish | source";
    };

    home.packages = with pkgs; [
      grc
      fzf
    ];

    ## Sets the default aliases for fish (bash based shells only)
    command-line.shell.aliases.basics.enable = lib.mkDefault true;

    programs.zoxide.enable = true;
    programs.bash = {
      enable = true;
      initExtra = ''
          if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
            then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
          fi
      '';
    };
  };
}
