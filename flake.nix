{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    arkenfox.url = "github:dwarfmaster/arkenfox-nixos";
    nievo.url = "path:/etc/nixos/nievo";
    stylix.url = "github:danth/stylix";
  };

  outputs =
    { nixpkgs
    , home-manager
    , stylix
    , ...
    } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      nixosConfigurations = {
        nixos-desktop = nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = {
            inherit inputs;
          };
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
