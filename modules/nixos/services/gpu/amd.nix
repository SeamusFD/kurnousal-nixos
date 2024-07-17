{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    services.gpu.amd.enable = lib.mkEnableOption "Enables the default amd gpu drivers and config";
  };
  config = lib.mkIf config.services.gpu.amd.enable {
    # Vulkan
    hardware.opengl.driSupport32Bit = true;
    # AMDVLK
    hardware.opengl.extraPackages = with pkgs; [
      amdvlk
    ];

    hardware.opengl.extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };
}
