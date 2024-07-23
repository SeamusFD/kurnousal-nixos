{ pkgs
, config
, lib
, ...
}: {
  options = {
    services.gpu.amd.enable = lib.mkEnableOption "Enables the default amd gpu drivers and config";
  };
  config = lib.mkIf config.services.gpu.amd.enable {
    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.kernelParams = [
      "amdgpu.msi=0"
      "amdgpu.aspm=0"
      "amdgpu.runpm=0"
      "amdgpu.bapm=0"
      "amdgpu.vm_update_mode=0"
      "amdgpu.exp_hw_support=1"
      "amdgpu.sched_jobs=64"
      "amdgpu.sched_hw_submission=4"
      "amdgpu.lbpw=0"
      "amdgpu.mes=1"
      "amdgpu.mes_kiq=1"
      "amdgpu.sched_policy=1"
      "amdgpu.ignore_crat=1"
      "amdgpu.no_system_mem_limit"
      "amdgpu.smu_pptable_id=0"
    ];
    services.xserver.videoDriver = [ "modesetting" ];
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    environment.variables.AMD_VULKAN_ICD = "RADV";
  };
}
