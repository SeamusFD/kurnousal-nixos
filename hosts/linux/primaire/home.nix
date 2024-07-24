{ pkgs
, inputs
, ...
}: {
  ### Home Manager Modules ###
  programs = {
    # Nix helper options
    nix-index.enable = true;

    # Ags options
    ags = {
      enable = true;
      configDir = ../../../modules/lib/ags;
      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };

    # Direnv options
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # Terminal options
    terminal = {
      kitty.enable = true;
      starship.enable = true;
      monitoring = {
        btop.enable = true;
        amdgpu.enable = true;
      };
    };

    # Browser options
    browser = {
      tor-browser.enable = true;
      arkenfox.enable = true;
      brave.enable = true;
    };

    # Office options
    office.libre-office.enable = true;

    # Music streaming options
    music.tidal.enable = true;

    # File manager options
    file-manager.nemo.enable = true;

    # Game-dev options
    game-dev.godot.enable = true;
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
  window-manager = {
    wayland.hyprland.enable = true;

    apps.rofi.enable = true;
    apps.waybar.enable = true;

    services = {
      notifications.dunst.enable = true;
    };
  };

  services = {
    remmina = {
      enable = true;
      systemdService.enable = true;
    };
  };

  rice.stylix.enable = true;

  development = {
    jetbrains.toolbox.enable = true;
    vcs.git.enable = true;
  };
  ### Home Manager Modules ###

  dconf.enable = true;
  home.packages = [
    inputs.nievo.packages.${pkgs.system}.default
    # Shell Packages
    # Theming packages
    # pkgs.catppuccin
    # pkgs.catppuccin-gtk
    # pkgs.catppuccin-qt5ct
    # (pkgs.catppuccin-kvantum.override {
    #   accent = "Blue";
    #   variant = "Mocha";
    # })
    # pkgs.libsForQt5.qtstyleplugin-kvantum
    # pkgs.libsForQt5.qt5ct
    # pkgs.kdePackages.qt6ct
    # pkgs.papirus-folders
    # pkgs.catppuccin-papirus-folders

    # Fix these and put them in the /development path
    (
      with inputs.fenix.packages.${pkgs.system};
      combine [
        complete.toolchain
        targets.x86_64-unknown-linux-musl.latest.rust-std
        targets.wasm32-unknown-unknown.latest.rust-std
      ]
    )
    pkgs.cargo-leptos
    pkgs.cargo-generate
    pkgs.openssl
    pkgs.pkg-config
    pkgs.wasm-pack
    pkgs.wasm-tools
    pkgs.sass
  ];

  # xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
  #   General.theme = "Catppuccin-Mocha-Blue";
  # };

  programs.jq.enable = true;

  services.cliphist.enable = true;
  services.network-manager-applet.enable = true;

  home.stateVersion = "24.05";
}
