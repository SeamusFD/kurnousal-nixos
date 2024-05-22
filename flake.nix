{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #stylix.url = "github:danth/stylix";
    #neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in 
  {
    nixosConfigurations = {
      nixos-desktop = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/nixos-desktop/configuration.nix
          ./modules/nixos
          home-manager.nixosModules.home-manager
        ];
      };
    };
    homeManagerModules.default = ./modules/home-manager;
  };
}
