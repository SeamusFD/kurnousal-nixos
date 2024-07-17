{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.command-line.shell.tools;
in {
  imports = [
    ./automation.nix
  ];

  options = {
    command-line.shell.tools.grep.enable = lib.mkEnableOption "Enables the grep tools";
    command-line.shell.tools.archive.enable = lib.mkEnableOption "Enables the archive tools with the default config";
  };
  config = lib.mkMerge [
    (lib.mkIf
      cfg.grep.enable
      {
        home.packages = with pkgs; [
          ripgrep
        ];
      })

    (lib.mkIf
      cfg.archive.enable
      {
        home.packages = with pkgs; [
          wget
          unzip
          unrar
        ];
      })
  ];
}
