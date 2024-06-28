{ pkgs
, config
, lib
, ...
}: {
  options = {
    programs.gaming.discord.enable = lib.mkEnableOption "Enables custom discord and it's subsequent services";
  };
  config = lib.mkIf config.programs.gaming.discord.enable {
    environment.systemPackages = [
      (pkgs.discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
    ];
  };
}
