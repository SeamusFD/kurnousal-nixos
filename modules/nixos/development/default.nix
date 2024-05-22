{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./python.nix
    ./c.nix
  ];
}
