{ pkgs
, inputs
, ...
}: {
  ### Home Manager Modules ###
  programs = {
    browser.tor-browser.enable = true;
    browser.arkenfox.enable = true;
    browser.brave.enable = true;
    music.tidal.enable = true;
    terminal.kitty.enable = true;
    terminal.starship.enable = true;
    terminal.monitoring.btop.enable = true;
    terminal.monitoring.amdgpu.enable = true;
    file-manager.nemo.enable = true;
  };
  command-line = {
    shell.fish.enable = true;
  };

  window-manager = {
    wayland.hyprland.enable = true;

    apps.rofi.enable = true;
    apps.waybar.enable = true;

    services = {
      notifications.dunst.enable = true;
    };
  };

  rice.stylix.enable = true;

  development.vcs.git.enable = true;
  ### Home Manager Modules ###

  dconf.enable = true;
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
  home.packages = [
    inputs.nievo.packages.${pkgs.system}.default
    # Shell Packages
    pkgs.neofetch
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
