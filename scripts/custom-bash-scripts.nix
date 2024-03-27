{pkgs, ...}:
with builtins; let
  rebuild = pkgs.writeShellScriptBin "rebuild" (builtins.readFile "/etc/nixos/kurnousal-nixos/scripts/nixos-rebuild.sh");
  set-primary-monitor = pkgs.writeShellScriptBin "set-primary-monitor" (builtins.readFile "/etc/nixos/kurnousal-nixos/scripts/primary-monitor.sh");
in {
  environment.systemPackages = [
    rebuild
    set-primary-monitor
  ];
}
