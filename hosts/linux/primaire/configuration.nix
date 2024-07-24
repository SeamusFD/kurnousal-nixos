{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Common imports used everywhere without config
    ../../common/nix-defaults
  ];

  environment = {
    super-user = {
      enable = true;
      userName = "bcampbell";
    };
    internationalisation.timezone.enable = true;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
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
  programs.gaming.lutris.enable = true;

  # Set host name
  services.network-conf.enable = true;
  services.network-conf.hostName = "primaire";
  services.bootloader.systemd-bootloader.enable = true;
  services.xserver.amd.enable = true;
  services.gpu.amd.enable = false;
  services.cpu.amd = {
    enable = true;
  };
  services.sound.enable = true;

  system = {
    fonts = {
      packages = with pkgs; [ nerdfonts twitter-color-emoji ];
      globalDefaults.enable = true;
      name = "CaskaydiaCove Nerd Font";
      serif = "CaskaydiaCove Nerd Font";
      sansSerif = "CaskaydiaCove Nerd Font";
      monospace = "CaskaydiaCove Nerd Font";
      emoji = "Twitter Color Emoji";
    };
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
    tree-sitter
    lact
    dconf
    glib
    xcur2png
    vim
    alejandra
    libnotify
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
    haskell-ci
    dotnet-sdk
    dotnet-sdk_7
    dotnet-sdk_8
    # Misc
    jdk
    sshpass
    wttrbar
    # Automation (move some day)
    nmap
    qbittorrent
    yt-dlp
    memtest86-efi
    memtest86plus
    memtest_vulkan
    memtester
    sops
    furmark
  ];

  programs.gamescope.enable = true;
  programs.java.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
