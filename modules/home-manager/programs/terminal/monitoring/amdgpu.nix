{ pkgs, config, lib, ... }:
{
  options = {
    programs.terminal.monitoring.amdgpu.enable = lib.mkEnableOption "Enable the amdgpu top console monitor with default config";
  };
  config = {
    home.packages = with pkgs; [
      amdgpu_top
    ];
  };
}
