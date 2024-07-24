{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixinate.url = "github:matthewcroughan/nixinate";
    sops-nix.url = "github:Mic92/sops-nix";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
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
    ags.url = "github:Aylur/ags";
  };

  outputs =
    { self
    , nixpkgs
    , nixinate
    , disko
    , nixos-wsl
    , home-manager
    , ...
    } @ inputs:
    let
      system = "x86_64-linux";
    in
    {
      apps = nixinate.nixinate.x86_64-linux self;
      nixosConfigurations = {
        # Primary Desktop
        primaire = nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = {
            inherit inputs;
          };
          modules = [
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
            {
              _module.args.nixinate = {
                host = "192.168.1.3";
                sshUser = "root";
                buildOn = "remote";
                substituteOnTarget = true;
                hermetic = false;
              };
            }
            { nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ]; }
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            ./hosts/server/lumiere/configuration.nix
            ./hosts/server/lumiere/disk-config.nix
            ./modules/nixos
            ./modules/server
          ];
        };
      };
      homeManagerModules.default = import ./modules/home-manager self;
    };
}
