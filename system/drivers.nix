{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_6_6.amdgpu-pro
    mesa
    vulkan-tools
    vulkan-utility-libraries
  ];
}
