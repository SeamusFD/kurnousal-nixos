{pkgs, ...}:
with builtins; let
  rebuild =
    pkgs.writeShellScriptBin "nix-rebuild"
    (builtins.readFile "/etc/nixos/kurnousal-nixos/scripts/nix/nixos-rebuild.sh");
  set-primary-monitor =
    pkgs.writeShellScriptBin "set-primary-monitor"
    (builtins.readFile "/etc/nixos/kurnousal-nixos/scripts/hyprland/primary-monitor.sh");
  gamemode =
    pkgs.writeShellScriptBin "gamemode"
    (builtins.readFile "/etc/nixos/kurnousal-nixos/scripts/hyprland/gamemode.sh");
in {
  environment.systemPackages = [
    rebuild
    set-primary-monitor
    gamemode
  ];
}
