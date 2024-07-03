{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Common imports used everywhere without config
    ../../common/nix-defaults/nix-features.nix
    ../../common/nix-defaults/nix-garbage-collection.nix
  ];

  environment.super-user.enable = true;
  environment.super-user.userName = "bcampbell";

  services.bootloader.systemd-bootloader.enable = true;
  services.network-conf.enable = true;

  home-manager.users.${config.environment.super-user.userName} = ./home.nix;
  home-manager.extraSpecialArgs = {
    inherit inputs;
  };
  home-manager.sharedModules = [
    inputs.self.outputs.homeManagerModules.default
    inputs.self.inputs.arkenfox.hmModules.arkenfox
    inputs.self.inputs.stylix.homeManagerModules.stylix
  ];

  programs.gaming.discord.enable = true;
  programs.gaming.steam.enable = true;

  # Set host name
  services.network-conf.hostName = "nixos-desktop";
  services.xserver.amd.enable = true;
  services.gpu.amd.enable = false;

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

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.etc = {
    "xdg/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
    '';
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Application Theming
    glib
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
    unrar
    protontricks
  ];

  programs.gamescope.enable = true;
  programs.java.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
