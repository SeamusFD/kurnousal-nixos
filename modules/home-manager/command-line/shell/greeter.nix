{ pkgs, config, lib, ... }:
let
  cfg = config.command-line.shell.greeter;
in
{
  options = {
    command-line.shell.greeter = {
      enable = lib.mkEnableOption "Enables the command-line greeter for your enabled shell";
      name = lib.mkOption {
        type = lib.types.str;
        default = "neofetch";
        description = "Name of the greeter";
      };
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.neofetch;
        description = "Package of the greeter (overrides name)";
      };
    };
  };
  config = lib.mkMerge [
    (lib.mkIf (cfg.name == "fastfetch" || cfg.package == pkgs.fastfetch) {
      programs.fastfetch = {
        enable = true;
        settings = {
          logo = {
            source = "nixos_large";
            # height = 20;
            padding = {
              top = 1;
            };
          };
          display = {
            separator = "  ";
          };
          modules = [
            "break"
            "break"
            "break"
            {
              type = "os";
              key = "OS   ";
              keyColor = 31;
            }
            {
              type = "kernel";
              key = " ├  ";
              keyColor = 31;
            }
            {
              type = "packages";
              format = "{} (pacman)";
              key = " ├ 󰏖 ";
              keyColor = 31;
            }
            {
              type = "shell";
              key = " └  ";
              keyColor = 31;
            }
            "break"
            {
              type = "wm";
              key = "WM   ";
              keyColor = 32;
            }
            {
              type = "wmtheme";
              key = " ├ 󰉼 ";
              keyColor = 32;
            }
            {
              type = "icons";
              key = " ├ 󰀻 ";
              keyColor = 32;
            }
            {
              type = "cursor";
              key = " ├  ";
            }
            {
              type = "terminal";
              key = " ├  ";
              keyColor = 32;
            }
            {
              type = "terminalfont";
              key = " └  ";
              keyColor = 32;
            }
            "break"
            {
              type = "host";
              format = "{5} {1} Type {2}";
              key = "PC   ";
              keyColor = 33;
            }
            {
              type = "cpu";
              format = "{1} {2} @ {12} GHz";
              key = " ├ 󰢮 ";
              keyColor = 33;
            }
            {
              type = "memory";
              key = " ├  ";
              keyColor = 33;
            }
            {
              type = "swap";
              key = " ├ 󰓡 ";
              keyColor = 33;
            }
            {
              type = "disk";
              key = " ├ 󰋊 ";
              keyColor = 33;
            }
            {
              type = "monitor";
              key = " └  ";
              keyColor = 33;
            }
            "break"
            "break"
          ];
        };
      };
    })
    (lib.mkIf (cfg ? "package") {
      home.packages = [
        cfg.package
      ];
    })
  ];
}
