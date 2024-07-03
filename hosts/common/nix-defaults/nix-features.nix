{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
}
