{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    programs.tor-browser.enable = lib.mkEnableOption "Enable the tor-browser package";
  };
  config = lib.mkIf config.programs.tor-browser.enable {
    home.packages = [
      pkgs.tor-browser
    ];
  };
}
