{ pkgs
, config
, lib
, ...
}: {
  options = {
    programs.browser.tor-browser.enable = lib.mkEnableOption "Enable the tor-browser package";
  };
  config = lib.mkIf config.programs.browser.tor-browser.enable {
    home.packages = [
      pkgs.tor-browser
    ];
  };
}
