{
  config,
  lib,
  ...
}: {
  options = {
    command-line.shell.aliases.basics.enable = lib.mkEnableOption "Enables the basic shell aliases for the default shell";
  };
  config = lib.mkIf config.command-line.shell.aliases.basics.enable {
    # Fallback bash aliases for when no other shell is specified
    programs.bash.shellAliases = lib.mkIf (!config.command-line.shell.fish.enable) {
      # ls aliases
      ll = "ls -l";
      la = "ls -a";
    };
    # Enable only when fish is being used as the default shell
    programs.fish.shellAliases = lib.mkIf config.command-line.shell.fish.enable {
      # ls aliases
      ll = "ls -l";
      la = "ls -a";
    };
  };
}
