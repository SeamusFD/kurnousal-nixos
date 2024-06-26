{ config, lib, ... }:
{
  options = {
    development.vcs.git.enable = lib.mkEnableOption "Enable the git vcs system";
  };
  config = lib.mkIf config.development.vcs.git.enable {
    programs.git = {
      enable = true;
      userName = "SeamusFD";
      userEmail = "armstrongmediahome@icloud.com";
    };
  };
}
