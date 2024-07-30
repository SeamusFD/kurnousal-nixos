{ pkgs, inputs, ... }:
{
  programs = {
    # Direnv options
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # Terminal options
    terminal = {
      starship.enable = true;
      monitoring.btop.enable = true;
    };
  };

  development.vcs.git.enable = true;
  rice.stylix.enable = true;
  dconf.enable = true;

  # Command line options
  command-line = {
    shell.fish.enable = true;
    shell.greeter = {
      enable = true;
      name = "fastfetch";
      package = pkgs.fastfetch;
    };
    shell.tools = {
      grep.enable = true;
      archive.enable = true;
    };
  };

  home.packages = [
    inputs.nievo.packages.${pkgs.system}.default
    pkgs.dconf
  ];
  home.stateVersion = "24.05";
}
