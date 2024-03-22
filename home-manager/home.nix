{ config, pkgs, ...}:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in 
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  users.users.bcampbell = {
    isNormalUser = true;
    description = "bcampbell";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      discord
      brave
      obsidian
      discord
      jetbrains-toolbox
      protonup-qt
    ];
  };

  home-manager.users.bcampbell = {
    imports = [
      ./hyprland/hyprland.nix
      ./kitty/kitty.nix
      ./fish/fish.nix
      ./neovim/nvim.nix
      # Removed until I figure out the rofi issues
      #./rofi/rofi.nix
    ];

    home.packages = with pkgs; [
      kitty
      fish
      fishPlugins.done
      fishPlugins.fzf-fish
      fishPlugins.forgit
      fishPlugins.hydro
      pfetch
    ];

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

    programs.git = {
      enable = true;
      userName = "SeamusFD";
      userEmail = "armstrongmediahome@icloud.com";
    };

    programs.starship = {
      enable = true;
      settings = {
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };

    home.stateVersion = "24.05";
  };
}
