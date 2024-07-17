{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    rice.stylix.enable = lib.mkEnableOption "Enables the default ricing config using stylix";
  };
  config = lib.mkIf config.rice.stylix.enable {
    stylix.enable = true;
    stylix.autoEnable = false;
    stylix.image = ../../lib/wallpapers/landscapes/horses.png;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    stylix.polarity = "dark";

    stylix.targets.gtk.enable = true;

    stylix.fonts = {
      sansSerif = {
        name = "CaskaydiaCove Nerd Font";
        package = pkgs.nerdfonts;
      };
      monospace = {
        name = "CaskaydiaCove Nerd Font";
        package = pkgs.nerdfonts;
      };
      emoji = {
        name = "Twitter Color Emoji";
        package = pkgs.twitter-color-emoji;
      };
    };

    stylix.cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 7;
    };

    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "mocha";
          accent = "blue";
        };
      };
    };
    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };
  };
}
