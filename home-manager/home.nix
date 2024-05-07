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
    extraGroups = ["networkmanager" "wheel" "libvirtd"];
    packages = [
      (pkgs.discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
      pkgs.brave
      # obsidian
      pkgs.tor-browser
      pkgs.jetbrains-toolbox
      pkgs.protonup-qt
      pkgs.freetube
      pkgs.spotube
      pkgs.libreoffice-fresh
      # Application Theming
      pkgs.glib
      pkgs.dconf
      pkgs.xcur2png
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
      ./thunderbird/default.nix
      # Removed until I figure out the rofi issues
      # ./rofi/rofi.nix
    ];

    dconf.enable = true;
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Catppuccin-Mocha-Standard-Blue-Dark";
        color-scheme = "prefer-dark";
      };

      # For Gnome shell
      "org/gnome/shell/extensions/user-theme" = {
        name = "Catppuccin-Mocha-Standard-Blue-Dark";
      };
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };

    home.sessionPath = ["/kutek/development/tree-sitter-paradox/node_modulesttree-sitter-cli/"];
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
      # Theming packages
      (catppuccin-kvantum.override {
        accent = "Blue";
        variant = "Mocha";
      })
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      papirus-folders
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
        name = "Catppuccin-Mocha-Standard-Blue-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = ["blue"];
          size = "compact";
          tweaks = ["rimless" "black"];
          variant = "mocha";
        };
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "mocha";
          accent = "blue";
        };
      };
      gtk3 = {
        extraConfig.gtk-application-prefer-dark-theme = true;
      };
      font = {
        name = "CaskaydiaCove Nerd Font";
        size = 11;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "qt5ct";
    };

    xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
      General.theme = "Catppuccin-Mocha-Blue";
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

    programs.jq.enable = true;

    services.cliphist.enable = true;
    services.network-manager-applet.enable = true;

    home.stateVersion = "24.05";
  };
}
