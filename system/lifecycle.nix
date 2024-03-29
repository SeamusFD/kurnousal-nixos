{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Packages for locking
    hyprlock
  ];
}
