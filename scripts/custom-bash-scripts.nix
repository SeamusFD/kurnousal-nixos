{pkgs, ...}:
with builtins; let
  rebuild = pkgs.writeShellScriptBin "rebuild" (builtins.readFile "/etc/nixos/kurnousal-home/scripts/nixos-rebuild.sh");
in {
  environment.systemPackages = [
    rebuild
  ];
}
