{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_6_6.rtl88xxau-aircrack
    linuxKernel.packages.linux_6_6.rtl8812au
  ];
}
