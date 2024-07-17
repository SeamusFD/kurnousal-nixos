{...}: {
  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    NIXOS_OZONE_WL = "1";
    OPENSSL_DIR = "/home/bcampbell/.nix-profile/bin/openssl";
    FLAKE = "/etc/nixos/kurnousal-nixos";
  };
}
