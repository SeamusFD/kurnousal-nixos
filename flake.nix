{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nur.url = "github:nix-community/NUR";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nievo = {
      url = "github:SeamusFD/Nievo";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    arkenfox.url = "github:dwarfmaster/arkenfox-nixos";
    stylix.url = "github:danth/stylix";
  };

  outputs =
    { self
    , nixpkgs
    , nixos-wsl
    , home-manager
    , nur
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
            { nixpkgs.overlays = [ nur.overlay ]; }
            ./hosts/linux/nixos-desktop/configuration.nix
            ./modules/nixos
            home-manager.nixosModules.home-manager
          ];
        };
        wsl-fedex = nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            # install wsl module for use on windows systems
            nixos-wsl.nixosModules.default
            ./hosts/wsl/wsl-fedex/configuration.nix
            ./modules/nixos
            home-manager.nixosModules.home-manager
          ];
        };
      };
      homeManagerModules.default = import ./modules/home-manager self;
    };
}
