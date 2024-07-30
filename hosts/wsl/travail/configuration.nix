{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    ../../common/nix-defaults
  ];
  wsl.enable = true;
  wsl.defaultUser = "travail";

  environment = {
    super-user = {
      enable = true;
      userName = "travail";
    };
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${config.environment.super-user.userName} = ./home.nix;
  home-manager.extraSpecialArgs = {
    inherit inputs;
  };
  home-manager.sharedModules = [
    inputs.self.outputs.homeManagerModules.default
    inputs.self.inputs.arkenfox.hmModules.arkenfox
    inputs.self.inputs.stylix.homeManagerModules.stylix
  ];

  environment.systemPackages = with pkgs; [
    vim
  ];

  system.stateVersion = "23.11";
}
