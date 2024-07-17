{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    programs.browser.brave.enable = lib.mkEnableOption "Enables the Brave application with default config";
  };
  config = lib.mkIf config.programs.browser.brave.enable {
    home.packages = with pkgs; [
      brave
    ];
  };
}
