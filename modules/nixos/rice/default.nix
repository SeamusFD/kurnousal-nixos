{ pkgs, config, ... }:
{
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.image = config.lib.stylix.pixel "base0A";
  stylix.fonts = {
    serif = {
      package = pkgs.nerdfonts;
      name = "CaskaydiaCove Nerd Font";
    };
    sansSerif = {
      package = pkgs.nerdfonts;
      name = "CaskaydiaCove Nerd Font";
    };
    monospace = {
      package = pkgs.nerdfonts;
      name = "CaskaydiaMono Nerd Font";
    };
    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };
  stylix.cursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 5;
  };
}
