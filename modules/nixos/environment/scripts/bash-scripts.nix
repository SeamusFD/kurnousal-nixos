{pkgs, ...}: let
  rebuild =
    pkgs.writeShellScriptBin "nix-rebuild"
    (builtins.readFile (../../../. + "/lib/scripts/nix/nixos-rebuild.sh"));
  set-primary-monitor =
    pkgs.writeShellScriptBin "set-primary-monitor"
    (builtins.readFile (../../../. + "/lib/scripts/hyprland/primary-monitor.sh"));
  gamemode =
    pkgs.writeShellScriptBin "gamemode"
    (builtins.readFile (../../../. + "/lib/scripts/hyprland/gamemode.sh"));
  toggle-blur =
    pkgs.writeShellScriptBin "toggle-blur"
    (builtins.readFile (../../../. + "/lib/scripts/hyprland/toggle-blur.sh"));
in {
  environment.systemPackages = [
    rebuild
    set-primary-monitor
    gamemode
    toggle-blur
  ];
}
