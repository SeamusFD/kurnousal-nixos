{ config
, lib
, ...
}: {
  options = {
    services.gpu.amd.enable = lib.mkEnableOption "Enables the default amd gpu drivers and config";
  };
  config = lib.mkIf config.services.gpu.amd.enable {
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.enable = true;
    services.xserver.videoDriver = [ "amdgpu" ];
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    hardware.enableRedistributableFirmware = true;
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    # environment.variables.AMD_VULKAN_ICD = "RADV";
  };
}
