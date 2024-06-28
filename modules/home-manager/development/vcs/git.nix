{ pkgs, config, lib, ... }:
{
  options = {
    development.vcs.git.enable = lib.mkEnableOption "Enable the git vcs system";
  };
  config = lib.mkIf config.development.vcs.git.enable {
    programs.git = {
      enable = true;
      package = pkgs.gitFull;
      userName = "SeamusFD";
      userEmail = "armstrongmediahome@icloud.com";
    };
  };
}
