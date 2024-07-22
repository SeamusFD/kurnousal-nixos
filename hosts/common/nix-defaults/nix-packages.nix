{ pkgs, config, lib, ... }:
let
  builtins = lib.builtins;
in
{
  # Show installed packages (https://www.reddit.com/r/NixOS/comments/fsummx/comment/fm45htj/?utm_source=share&utm_medium=web2x&context=3)
  environment.etc."current-system-packages".text =
    let
      packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
      sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
      formatted = builtins.concatStringsSep "\n" sortedUnique;
    in
    formatted;
}
