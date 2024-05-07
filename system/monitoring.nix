{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    amdgpu_top
    nix-top
    btop
    wirelesstools
    usbutils
    tree-sitter
  ];
}
