{ pkgs
, inputs
, lib
, ...
}: {
  programs.rust.customToolchain.toolchainPackage = inputs.fenix.packages.${pkgs.system}.complete.toolchain;
  programs.rust.cargo-leptos = {
    enable = true;
    package = pkgs.cargo-leptos;
  };

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
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    size = 7;
  };
  home.packages = [
    inputs.nievo.packages.${pkgs.system}.default
    # Shell Packages
    pkgs.fzf
    pkgs.grc
    pkgs.neofetch
    # Theming packages
    pkgs.catppuccin
    pkgs.catppuccin-gtk
    pkgs.catppuccin-qt5ct
    (pkgs.catppuccin-kvantum.override {
      accent = "Blue";
      variant = "Mocha";
    })
    pkgs.libsForQt5.qtstyleplugin-kvantum
    pkgs.libsForQt5.qt5ct
    pkgs.papirus-folders
    pkgs.catppuccin-papirus-folders

    # Fix these and put them in the /development path
    pkgs.cargo-leptos
    pkgs.cargo-generate
    pkgs.wasm-pack
    pkgs.wasm-tools
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
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
    gtk4 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
    font = lib.mkDefault {
      name = "CaskaydiaCove Nerd Font";
      size = 11;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
    General.theme = "Catppuccin-Mocha-Blue";
  };

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
      palette = "catppuccin_mocha";
      character = {
        success_symbol = "[[♥](green) ❯](maroon)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };
      directory = {
        truncation_length = 4;
        style = "bold lavender";
      };
      palettes.catppuccin_mocha = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };
    };
  };

  programs.jq.enable = true;

  services.cliphist.enable = true;
  services.network-manager-applet.enable = true;

  home.stateVersion = "24.05";
}
