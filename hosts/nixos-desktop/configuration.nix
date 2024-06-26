{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  super-user.enable = true;
  super-user.userName = "bcampbell";

  home-manager.users.${config.super-user.userName} = ./home.nix;
  home-manager.extraSpecialArgs = {
    inherit inputs;
  };
  home-manager.sharedModules = [
    inputs.self.outputs.homeManagerModules.default
    inputs.self.inputs.arkenfox.hmModules.arkenfox
    inputs.self.inputs.stylix.homeManagerModules.stylix
  ];

  gaming.discord.enable = true;

  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];

  # Set host name
  services.network-conf.hostName = "nixos-desktop";

  # Set your time zone.
  time.timeZone = "America/Chicago";

  fonts = {
    packages = with pkgs; [
      nerdfonts
      twitter-color-emoji
    ];
    fontconfig.defaultFonts = {
      serif = [ "CaskaydiaCove Nerd Font" ];
      sansSerif = [ "CaskaydiaCove Nerd Font" ];
      monospace = [ "CaskaydiaMono Nerd Font" ];
      emoji = [ "Twitter Color Emoji" ];
    };
  };
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  environment.etc = {
    "xdg/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
    '';
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    jetbrains-toolbox
    protonup-qt
    # Application Theming
    glib
    dconf
    xcur2png
    vim
    nodejs
    nodePackages_latest.pnpm
    alejandra
    libnotify
    wget
    unzip
    xwayland
    swww
    openvpn
    protonvpn-cli_2
    vlc
    # Build Tools
    meson
    scdoc
    coreutils
    xdotool
    xorg.xwininfo
    yad
    wayland-protocols
    wayland-utils
    wlroots
    # Programming Tools
    go
    ruby
    nim
    nimble
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
    jdk
    flatpak
    sshpass
    wttrbar
    # Automation (move some day)
    ansible
    nmap
    qbittorrent
    youtube-dl
    tree-sitter
  ];

  programs.virt-manager = {
    enable = true;
  };
  programs.gamescope.enable = true;
  programs.java.enable = true;
  virtualisation.libvirtd.enable = true;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "23.11"; # Did you read the comment?
}
