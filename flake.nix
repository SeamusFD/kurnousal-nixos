{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
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
    , disko
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
        # Primary Desktop
        primaire = nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            { nixpkgs.overlays = [ nur.overlay ]; }
            ./hosts/linux/primaire/configuration.nix
            ./modules/nixos
            home-manager.nixosModules.home-manager
          ];
        };
        # Primary Work Laptop
        travail = nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            # install wsl module for use on windows systems
            nixos-wsl.nixosModules.default
            ./hosts/wsl/travail/configuration.nix
            ./modules/nixos
            home-manager.nixosModules.home-manager
          ];
        };
        # Primary Server
        lumiere = nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            { nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ]; }
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            ./hosts/server/lumiere/configuration.nix
            ./hosts/server/lumiere/disk-config.nix
            ./modules/nixos
          ];
        };
      };
      homeManagerModules.default = import ./modules/home-manager self;
    };
}
