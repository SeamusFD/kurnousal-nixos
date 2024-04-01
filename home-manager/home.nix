{
  config,
  pkgs,
  ...
}: let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in {
  imports = [
    (import "${home-manager}/nixos")
  ];
  users.users.bcampbell = {
    isNormalUser = true;
    description = "bcampbell";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      discord
      brave
      obsidian
      tor-browser
      discord
      jetbrains-toolbox
      protonup-qt
      freetube
      spotube
      libreoffice-fresh
      # Application Theming
      glib
      gsettings-qt
      dconf
      xcur2png
    ];
  };

  home-manager.users.bcampbell = {
    imports = [
      ./hyprland/hyprland.nix
      ./kitty/kitty.nix
      ./fish/fish.nix
      ./neovim/nvim.nix
      ./waybar/waybar.nix
      ./dunst/dunst.nix
      ./shell-aliases.nix
      ./xserver/xserver.nix
      # Removed until I figure out the rofi issues
      #./rofi/rofi.nix
    ];

    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };

    home.packages = with pkgs; [
      kitty
      # Shell Packages
      fish
      fishPlugins.done
      fishPlugins.fzf-fish
      fishPlugins.forgit
      fishPlugins.hydro
      fzf
      fishPlugins.grc
      grc
      pfetch
    ];

    home.pointerCursor = {
      name = "Bibata-Modern-Classic";
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      size = 5;
    };

    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Macchiato-Standard-Blue-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = ["blue"];
          size = "compact";
          tweaks = ["rimless" "black"];
          variant = "mocha";
        };
      };
      iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
      };

      font = {
        name = "CaskaydiaCove Nerd Font";
        size = 11;
      };
    };

    # xdg.configFile = {
    #   "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    #   "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    #   "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    # };

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
