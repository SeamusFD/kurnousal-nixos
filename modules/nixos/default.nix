{ lib, ... }: {
  # This determines our default non home-manager nix configurations. This is present across all machines unless edited by the specific machine config.
  imports = [
    # Folder default imports
    ./services
    ./lifecycle
    ./environment
    ./development
    ./programs
    ./peripherals
  ];
}
