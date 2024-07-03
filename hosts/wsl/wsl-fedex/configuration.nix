{ config, lib, pkgs, ... }:
{
  imports = [
    ../../common/nix-defaults/nix-features.nix
    ../../common/nix-defaults/nix-garbage-collection.nix
  ];
  wsl.enable = true;
  wsl.defaultUser = "wsl-fedex";

  system.stateVersion = "23.11";
}
