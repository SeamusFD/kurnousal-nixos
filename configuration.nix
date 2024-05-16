{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./home-manager/home.nix
    ./hardware-configuration.nix
    ./system/bluetooth.nix
    ./system/lifecycle.nix
    # ./system/sddm.nix
    ./system/pentesting-utils.nix
    ./system/monitoring.nix
    ./system/godot.nix
    ./system/keyboard.nix
    ./system/drivers.nix
    ./system/python/default.nix
    ./scripts/custom-bash-scripts.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-a020a96e-79d9-4fc2-ac8d-e310b24c49f8".device = "/dev/disk/by-uuid/a020a96e-79d9-4fc2-ac8d-e310b24c49f8";
  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];
  xdg.portal.configPackages = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];
  services.flatpak.enable = true;

  fonts = {
    packages = with pkgs; [
      nerdfonts
      noto-fonts-emoji
    ];
    fontconfig.defaultFonts = {
      serif = ["CaskaydiaCove Nerd Font"];
      sansSerif = ["CaskaydiaCove Nerd Font"];
      monospace = ["CaskaydiaMono Nerd Font"];
      emoji = ["CaskaydiaCove Nerd Font"];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    nodejs
    nodePackages_latest.pnpm
    alejandra
    libnotify
    wget
    unzip
    rofi-wayland
    xwayland
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    swww
    dolphin
    openvpn
    protonvpn-cli_2
    vlc
    # Build Tools
    meson
    cmake
    scdoc
    coreutils
    gcc
    xdotool
    xorg.xwininfo
    yad
    wayland-protocols
    wayland-utils
    wl-clipboard
    wlroots
    # Programming Tools
    rustup
    go
    ruby
    nim
    #
    ripgrep
    unzip
    haskell-ci
    dotnet-sdk
    dotnet-sdk_7
    dotnet-sdk_8
    # Sound
    pavucontrol
    qpwgraph
    # Virtualization
    qemu
    quickemu
    qemu_full
    qemu_kvm
    qemu-utils
    # Misc
    unicode-emoji
    twitter-color-emoji
    jdk
    flatpak
    sshpass
    wttrbar
    # Automation (move some day)
    ansible
  ];

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          libkrb5
          keyutils
        ];
    };
  };
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
        softrealtime = "auto";
        desiredgov = "performance";
        inhibit_screensaver = 0;
      };

      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };
  programs.gamescope.enable = true;
  programs.java.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "23.11"; # Did you read the comment?
}
