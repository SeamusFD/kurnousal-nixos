{ pkgs, lib, config, ... }:
let
  cfg = config.services.cpu.amd;
in
{
  options = {
    services.cpu.amd = {
      enable = lib.mkEnableOption "Enable AMD Cpu support.";
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      kernelModules = [ "kvm-amd" ];
      kernelParams = [ "amd_pstate=active" ];
    };
    hardware.cpu.amd.updateMicrocode = lib.mkDefault true;
  };
}
